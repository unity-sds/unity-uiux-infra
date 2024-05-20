variable "cognito_dev_url" {
  description = "The URL for the Development instance of our Cognito User Pool"
  default     = "https://unitysds.auth.us-west-2.amazoncognito.com/"
  type        = string
}

variable "cognito_test_url" {
  description = "The URL for the Development instance of our Cognito User Pool"
  default     = "https://unitysds-test.auth.us-west-2.amazoncognito.com/"
  type        = string
}

variable "cognito_prod_url" {
  description = "The URL for the Development instance of our Cognito User Pool"
  default     = "https://unity-shared-services-prod.auth.us-west-2.amazoncognito.com/"
  type        = string
}

variable "cognito_dev_provider_url" {
  description = "The Cognito OAUTH Provider URL for the dev venue"
  default     = var.cognito_dev_url + "/oauth2"
  type        = string
}

variable "cognito_test_provider_url" {
  description = "The Cognito OAUTH Provider URL for the test venue"
  default     = var.cognito_test_url + "/oauth2"
  type        = string
}

variable "cognito_prod_provider_url" {
  description = "The Cognito OAUTH Provider URL for the prod venue"
  default     = var.cognito_prod_url + "/oauth2"
  type        = string
}

variable "cognito_dev_logout_url" {
  description = "The Cognito logout URL for the dev venue"
  default     = var.cognito_dev_url + "/logout"
  type        = string
}

variable "cognito_test_logout_url" {
  description = "The Cognito logout URL for the test venue"
  default     = var.cognito_test_url + "/logout"
  type        = string
}

variable "cognito_prod_logout_url" {
  description = "The Cognito logout URL for the prod venue"
  default     = var.cognito_prod_url + "/logout"
  type        = string
}

variable "deployment_name" {
  description = "Unique name of this deployment in the account."
  type        = string
}

variable "installprefix" {
  description = "The management console install prefix"
  type        = string
  default     = "unity-ui"
}

variable "project" {
  description = "The project or mission deploying Unity SPS"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-west-2"
}

variable "release" {
  description = "The UI release version"
  type        = string
}

variable "service_area" {
  description = "The service area owner of the resources being deployed"
  type        = string
  default     = "uiux"
}

variable "tags" {
  description = "AWS Tags"
  type        = map(string)
}

variable "template" {
  default = <<EOT
                  RewriteEngine on
                  ProxyPass /dashboard http://test-demo-alb-616613476.us-west-2.elb.amazonaws.com:8888/dashboard/hello.jsp
                  ProxyPassReverse /dashboard http://test-demo-alb-616613476.us-west-2.elb.amazonaws.com:8888/dashboard/hello.jsp
EOT
}

variable "venue" {
  description = "The MCP venue in which the cluster will be deployed (dev, test, prod)"
  type        = string
}
