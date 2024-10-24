resource "aws_ecs_cluster" "main" {
  name = "${var.project}-${var.venue}-dashboard-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family = "${var.project}-${var.venue}-dashboard-app"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = "256"
  memory = "512"
  container_definitions = jsonencode(
    [
      {
        name = "dashboard"
        image = var.app_image
        environment = [
          {
            name = "ENV_UNITY_UI_PROJECT"
            value = "${var.project}"
          },
          {
            name = "ENV_UNITY_UI_VENUE"
            value = "${var.venue}"
          },
          {
            name = "ENV_UNITY_UI_ADMIN_EMAIL"
            value = ""
          },
          {
            name = "ENV_UNITY_UI_WWW_DOMAIN"
            value = "www.${data.aws_ssm_parameter.shared_services_domain.value}"
          },
          {
            name = "ENV_UNITY_UI_BASE_PATH"
            value = "/${var.project}/${var.venue}/dashboard"
          },
          /* {
            name = "ENV_UNITY_UI_AUTH_OAUTH_CLIENT_ID"
            value = var.cognito_client_id
          }, */
          {
            name = "ENV_UNITY_UI_AUTH_OAUTH_REDIRECT_URI"
            value = "https://www.${data.aws_ssm_parameter.shared_services_domain.value}:4443/${var.project}/${var.venue}/dashboard"
          },
          {
            name = "ENV_UNITY_UI_AUTH_OAUTH_LOGOUT_ENDPOINT"
            value = "${data.aws_ssm_parameter.cognito_domain.value}/logout"
          },
          {
            name = "ENV_UNITY_UI_AUTH_OAUTH_PROVIDER_URL"
            value = "${data.aws_ssm_parameter.cognito_domain.value}/oauth2"
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
            name = "ENV_UNITY_UI_HEALTH_API_ENDPOINT"
            value = "https://api.${data.aws_ssm_parameter.shared_services_domain.value}/${var.project}/${var.venue}/management/api/health_checks"
          },
        ]
        portMappings = [
          {
            containerPort = 8080
            hostPort = 8080
          }
        ]
      }
    ]
  )
}

resource "aws_ecs_service" "main" {
  name            = "${var.project}-${var.venue}-dashboard-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs_sg.id]
    subnets = local.private_subnet_ids
    assign_public_ip = true // Needed so it can pull images
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name = "dashboard"
    container_port = 8080
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role_policy]
}