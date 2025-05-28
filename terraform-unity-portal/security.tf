resource "aws_security_group" "ecs_sg" {
  name = "${var.project}-${var.venue}-ui-ecs-sg"
  description = "Security group for the Portal ECS Service Network Configuration"
  vpc_id = data.aws_ssm_parameter.vpc_id.value

  tags = merge(
    var.tags,
    var.additional_tags,
    {
      Venue = var.venue
      Proj = var.project
    }
  )

}

resource "aws_vpc_security_group_ingress_rule" "ecs_sg_ingress" {
  security_group_id            = aws_security_group.ecs_sg.id
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_vpc_security_group_egress_rule" "ecs_sg_egress" {
  security_group_id            = aws_security_group.ecs_sg.id
  ip_protocol                  = "-1"
  cidr_ipv4                    = "0.0.0.0/0"
}

resource "aws_security_group" "alb_sg" {
  name = "${var.project}-${var.venue}-ui-alb-sg"
  description = "Security group for the Portal ALB"
  vpc_id = data.aws_ssm_parameter.vpc_id.value

  tags = merge(
    var.tags,
    var.additional_tags,
    {
      Venue = var.venue
      Proj = var.project
    }
  )

}

resource "aws_vpc_security_group_ingress_rule" "alb_sg_ingress" {
  count                        = length(data.aws_security_groups.venue_httpd_proxy_sg.ids) > 0 ? 1 : 0
  security_group_id            = aws_security_group.alb_sg.id
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
  referenced_security_group_id = data.aws_security_groups.venue_httpd_proxy_sg.ids[0]
}

resource "aws_vpc_security_group_egress_rule" "alb_sg_egress" {
  security_group_id            = aws_security_group.alb_sg.id
  ip_protocol                  = "-1"
  cidr_ipv4                    = "0.0.0.0/0"
}