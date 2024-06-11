# Create an Application Load Balancer (ALB)
resource "aws_lb" "ui_application_alb" {
  name               = "${var.deployment_name}-ui-application-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_sg.id]
  subnets            = local.public_subnet_ids
  enable_deletion_protection = false
  tags = {
    Service = "U-UIUX"
  }
}

# Create a Target Group for UI Application
resource "aws_lb_target_group" "ui_application_tg" {
  name     = "${var.deployment_name}-ui-application-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.vpc_id.value
  target_type = "ip"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
  }
  tags = {
    Service = "U-UIUX"
  }
}

# Create a Listener for the ALB that forwards requests to the httpd Target Group
resource "aws_lb_listener" "ui_application_listener" {
  load_balancer_arn = aws_lb.ui_application_alb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ui_application_tg.arn
  }
  tags = {
    Service = "U-UIUX"
  }
}

output "ui_application_alb_url" {
  value = aws_lb.ui_application_alb.dns_name
}