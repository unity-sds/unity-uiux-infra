resource "aws_lb" "main" {
  name = "${var.project}-${var.venue}-dashboard-lb"
  internal = false
  load_balancer_type = "application"
  subnets = local.public_subnet_ids
  security_groups = [aws_security_group.ecs_sg.id]
  enable_deletion_protection = false
  tags = merge(
    var.tags,
    var.default_tags,
    {},
  )
}

resource "aws_alb_target_group" "app" {
  name        = "${var.project}-${var.venue}-dashboard-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  target_type = "ip"

  health_check {
    healthy_threshold   = 3
    interval            = 30
    matcher             = "200"
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
  tags = merge(
    var.tags,
    var.default_tags,
    {},
  )
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.id
  port = 8080
  protocol = "HTTP"
  tags = merge(
    var.tags,
    var.default_tags,
    {},
  )

  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.app.id
  }
}