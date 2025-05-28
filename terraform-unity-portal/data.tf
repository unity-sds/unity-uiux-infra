// Get the account ID of shared services
data "aws_ssm_parameter" "ssAcctNum" {
  name = "/unity/shared-services/aws/account"
}

data "aws_ssm_parameter" "cognito_domain" {
  name = "arn:aws:ssm:${data.aws_ssm_parameter.aws_account_region.value}:${data.aws_ssm_parameter.ssAcctNum.value}:parameter/unity/shared-services/cognito/domain"
}

data "aws_iam_policy" "mcp_operator_policy" {
  name = "mcp-tenantOperator-AMI-APIG"
}

data "aws_ssm_parameter" "subnet_list" {
  name = "/unity/account/network/subnet_list"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/unity/account/network/vpc_id"
}

data "aws_ssm_parameter" "shared_services_domain" {
  name = "arn:aws:ssm:${data.aws_ssm_parameter.aws_account_region.value}:${data.aws_ssm_parameter.ssAcctNum.value}:parameter/unity/shared-services/domain"
}

data "aws_ssm_parameter" "aws_account_region" {
  name = "/unity/shared-services/aws/account/region"
}

data "aws_subnet" "private_subnets" {
  for_each = "${toset(local.private_subnet_ids)}"
  id       = "${each.value}"
}

data "aws_subnet" "public_subnets" {
  for_each = "${toset(local.public_subnet_ids)}"
  id       = "${each.value}"
}

data "aws_security_groups" "venue_httpd_proxy_sg" {
  filter {
    name   = "group-name"
    values = ["${var.project}-${var.venue}-ecs_service_sg"]
  }
  tags = {
    Service = "U-CS"
  }
}