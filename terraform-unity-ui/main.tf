# Terraform driver to instantiate the Unity UI via Unity Marketplace

data "aws_ssm_parameter" "vpc_id" {
  name = "/unity/account/network/vpc_id"
}

data "aws_ssm_parameter" "subnet_list" {
  name = "/unity/account/network/subnet_list"
}

data "aws_ssm_parameter" "proxylambda" {
  name = "/unity/cs/management/proxy/${var.installprefix}-httpd-lambda-name"
}

data "aws_iam_policy" "mcp_operator_policy" {
  name = "mcp-tenantOperator-AMI-APIG"
}

# This SSM parameter references the predefined cognito user pool
data "aws_ssm_parameter" "cognito_user_pool" {
  name = "/unity/cs/security/shared-services-cognito-user-pool/user-pool-id"
}

data "aws_ssm_parameter" "ssAcctNum" {
  name = "/unity/shared-services/aws/account"
}

data "aws_ssm_parameter" "cognito_domain" {
  name = "arn:aws:ssm:us-west-2:${data.aws_ssm_parameter.ssAcctNum}:parameter/unity/shared-services/cognito/domain"
}

# todo: Get this param added to SSM
# Reference: https://github.com/unity-sds/unity-cs/issues/375
data "aws_ssm_parameter" "cloudfront_distribution_id" {
  name = "/unity/shared-services/cloudfront/distribution"
}

data "aws_cloudfront_distribution" "cloudfront_distribution" {
  id = data.aws_ssm_parameter.cloudfront_distribution_id
}

data "aws_iam_policy" "mcp_operator_policy" {
  name = "mcp-tenantOperator-AMI-APIG"
}

data "aws_cognito_user_pool_client" "unity_ui_client" {
  client_id = unity_ui_cognito_client_id
  user_pool_id = data.aws_ssm_parameter.cognito_user_pool.id
}

#todo add airflow url configuation

locals {
  subnet_map = jsondecode(data.aws_ssm_parameter.subnet_list.value)
  subnet_ids = nonsensitive(local.subnet_map["private"])
  public_subnet_ids = nonsensitive(local.subnet_map["public"])
}

#####################

resource "aws_lambda_invocation" "demoinvocation2" {
  function_name = data.aws_ssm_parameter.proxylambda.value

  input = jsonencode({
    filename  = "proxy-lambda-${var.installprefix}",
    template = var.template
  })

}
