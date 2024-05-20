resource "aws_ecs_cluster" "ui_application_cluster" {
  name = "${var.deployment_name}-ui-application-cluster"
  tags = {
    ServiceArea = "uiux"
  }
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "${var.deployment_name}ecs_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  permissions_boundary = data.aws_iam_policy.mcp_operator_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "ui_application_task_definition" {
  family                   = "ui_application"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  memory                   = "512"
  cpu                      = "256"
  volume {
    name = "ui-application-config"

    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.ui_application_config_efs.id
      root_directory          = "/"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2049
    }
  }

  container_definitions = jsonencode([{
    name  = "ui-application"
    image = "ghcr.io/unity-sds/unity-ui-infra:latest"
    environment = [
      {
        name = "VPC_ID",
        value = data.aws_ssm_parameter.vpc_id.value
      },
      {
        name = "ENV_UNITY_UI_AUTH_OAUTH_CLIENT_ID"
        valueFrom = unity_ui_cognito_client_id
      },
      {
        name = "ENV_UNITY_UI_AUTH_OAUTH_REDIRECT_URI"
        value = "${data.aws_cloudfront_distribution.cloudfront_distribution.domain_name}/dashboard"
      },
      {
        name = "ENV_UNITY_UI_AUTH_OAUTH_LOGOUT_ENDPOINT"
        value = (var.venue == "dev" ? var.cognito_dev_logout_url : (var.venue == "test" ? var.cognito_test_logout_url : (var.venue == "prod" ? var.cognito_prod_logout_url : "")))
      },
      {
        name = "ENV_UNITY_UI_AUTH_OAUTH_PROVIDER_URL"
        value = (var.venue == "dev" ? var.cognito_dev_provider_url : (var.venue == "test" ? var.cognito_test_provider_url : (var.venue == "prod" ? var.cognito_prod_provider_url : "")))
      },
      {
        name = "ENV_UNITY_UI_AUTH_APP_ADMIN_GROUP_NAME"
        value = "Unity_Admin"
      },
      {
        name = "ENV_UNITY_UI_AUTH_APP_APP_VIEWER_GROUP_NAME"
        value = "Unity_Viewer"
      },
      {
        name = "ENV_UNITY_UI_STAC_BROWSER_URL"
        value = ""  # todo insert stac browser url
      },
      {
        name = "ENV_UNITY_UI_SPS_WPST_ENDPOINT"
        value = "${data.aws_cloudfront_distribution.cloudfront_distribution.domain_name}/ades-wpst"
      },
      {
        name = "ENV_UNITY_UI_HEALTH_DASHBOARD_ENDPOINT"
        value = ""  # todo insert health dashboard url
      },
      {
        name = "ENV_UNITY_UI_AIRFLOW"
        value = ""  # todo insert airflow url (need to )
      },
      {
        name = "ENV_UNITY_UI_ADMIN_EMAIL"
        value = "anil.natha@jpl.nasa.gov"
      }
    ]
    portMappings = [
      {
        containerPort = 8888
        hostPort      = 8888
      }
    ]
    mountPoints = [
      {
        containerPath = "/etc/apache2/sites-enabled/"
        sourceVolume  = "ui-application-config"
      }
    ]
  }])
  tags = {
    ServiceArea = "uiux"
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.deployment_name}-ecs_service_sg"
  description = "Security group for ECS service"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  // Inbound rules
  // Example: Allow HTTP and HTTPS
  ingress {
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Outbound rules
  // Example: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    ServiceArea = "uiux"
  }
}

# Update the ECS Service to use the Load Balancer
resource "aws_ecs_service" "ui_application_service" {
  name            = "ui-application-service"
  cluster         = aws_ecs_cluster.ui_application_cluster.id
  task_definition = aws_ecs_task_definition.ui_application_task_definition.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.ui_application_tg.arn
    container_name   = "ui-application"
    container_port   = 8888
  }

  network_configuration {
    subnets         = local.subnet_ids
    security_groups = [aws_security_group.ecs_sg.id]
    #needed so it can pull images
    assign_public_ip = true
  }
  tags = {
    ServiceArea = "uiux"
  }
  depends_on = [
    aws_lb_listener.ui_application_listener,
  ]
}

output "aws_alb_domain" {
  value = aws_ecs_service.ui_application_service.load_balancer.dns_name
}