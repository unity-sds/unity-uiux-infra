variable "app_count" {
  default = 2
  description = "The minimum number of application containers to run in the cluster"
  type = number
}

variable "app_image" {
  description = "The docker image to run the application."
  default = "ghcr.io/unity-sds/unity-ui/unity-ui-application:latest"
  type = string
}

variable "deployment_name" {
  description = "Unique name of this deployment in the account."
  type        = string
}

variable "installprefix" {
  description = "The management console install prefix"
  type        = string
}

variable "project" {
  description = "The project or mission deploying Unity SPS"
  type        = string
}

variable "region" {
  description = "The region in which region scoped services should be deployed."
  type        = string
}

variable "tags" {
  description = "AWS Tags"
  type        = map(string)
}

variable "venue" {
  description = "The MCP venue in which the cluster will be deployed (dev, test, prod)"
  type        = string
}

variable "cognito_client_id" {
  description = "The Cognito App Client ID"
  type        = string
}