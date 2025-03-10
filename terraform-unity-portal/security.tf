resource "aws_security_group" "ecs_sg" {
  name = "${var.project}-${var.venue}-ui-ecs-sg"
  description = "Security group for the UI ECS Service"
  vpc_id = data.aws_ssm_parameter.vpc_id.value

  tags = merge(
    var.tags,
    var.additional_tags,
    {
      Venue = var.venue
      Proj = var.project
    }
  )

  // Inbound rules
  // Example: Allow HTTP and HTTPS
  ingress {
    from_port   = 8080
    to_port     = 8080
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
}