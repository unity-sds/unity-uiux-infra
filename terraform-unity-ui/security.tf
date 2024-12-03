resource "aws_security_group" "ecs_sg" {
  name = "${var.project}-${var.venue}-dashboard-ecs-sg"
  description = "Security group for the dashboard ECS Service"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  tags = {
    Venue = "dev",
    ServiceArea = "uiux",
    CapVersion = "0.8.0"
    Component = "Navbar",
    Proj = "Unity",
    CreatedBy = "uiux",
    Env = "dev",
    Stack = "UI"
  }

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