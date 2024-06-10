# =============================================================================
# This terraform configuration for cognito intends to create a app integration
# so that user authentication can be processed by our cognito user pool
# =============================================================================

resource "aws_cognito_user_pool_client" "userpool_client" {
  name = "${var.deployment_name}-unity-ui-client"
  user_pool_id = data.aws_ssm_parameter.cognito_user_pool.id
  access_token_validity = 60
  allowed_oauth_flows = ["code"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes = ["email", "openid", "profile"]
  auth_session_validity = 3
  callback_urls = ["https://www.dev.mdps.mcp.nasa.gov:4443/${var.project}/${var.venue}/dashboard"]
  enable_token_revocation = true
  explicit_auth_flows = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]
  generate_secret = false
  id_token_validity = 60
  logout_urls = []    // todo: determine if logout urls are needed
  prevent_user_existence_errors = "ENABLED"
  refresh_token_validity = 30
  supported_identity_providers = ["COGNITO"]

  token_validity_units {
    // Valid values are: seconds | minutes | hours | days
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}

output "unity_ui_cognito_client_id" {
  value = aws_cognito_user_pool_client.userpool_client.id
}