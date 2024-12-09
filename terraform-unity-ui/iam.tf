resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project}-${var.venue}-dashboard-ecs_task_execution_role"
  tags = {
    Venue = "dev"
    ServiceArea = "uiux"
    CapVersion = "0.8.0"
    Component = "navbar"
    Proj = "Unity"
    CreatedBy = "uiux"
    Env = "dev"
    Stack = "ui"
  }

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

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

