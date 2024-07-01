// Get the account ID of shared services
data "aws_ssm_parameter" "ssAcctNum" {
  name = "/unity/shared-services/aws/account"
}

data "aws_ssm_parameter" "cognito_domain" {
  name = "/unity/shared-services/cognito/domain"
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
  name = "arn:aws:ssm:us-west-2:${data.aws_ssm_parameter.ssAcctNum.value}:parameter/unity/shared-services/domain"
}