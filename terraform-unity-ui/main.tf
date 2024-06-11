# Terraform driver to instantiate the Unity UI via Unity Marketplace

data "aws_ssm_parameter" "vpc_id" {
  name = "/unity/account/network/vpc_id"
}

data "aws_ssm_parameter" "subnet_list" {
  name = "/unity/account/network/subnet_list"
}

data "aws_ssm_parameter" "proxylambda" {
  name = "/unity/${var.project}/${var.venue}/cs/management/proxy/lambda-name"
}

data "aws_iam_policy" "mcp_operator_policy" {
  name = "mcp-tenantOperator-AMI-APIG"
}

data "aws_ssm_parameter" "cognito_user_pool" {
  name = "/unity/cs/security/shared-services-cognito-user-pool/user-pool-id"
}

data "aws_ssm_parameter" "cognito_domain" {
  name = "/unity/shared-services/cognito/domain"
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
