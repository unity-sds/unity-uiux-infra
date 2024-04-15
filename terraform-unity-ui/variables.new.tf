variable "add_routes_to_api_gateway" {
  description = "If true, adds routes to api gateway configured in account"
  type        = bool
  default     = false
}

variable "capability" {
  description = "The capability being provided to Unity."
  type        = string
}

variable "capability_version" {
  description = "The version of the capability being provided."
  type        = string
}

variable "component" {
  description = "The primary type of application/runtime that will be run on this resource."
  type        = string
}

variable "created_by" {
  description = "This should contain the same value as the 'service_area' variable (tag)."
}

variable "deployment_name" {
  description = "Unique name of this deployment in the account."
  type        = string
}

variable "installprefix" {
  description = "The management console install prefix"
  type        = string
  default     = "UnknownPrefix"
}

variable "environment" {
  description = "This should contain the same value as the 'venue' variable (tag)."
}

variable "name" {
  description = "The name of the AWS resource. All characters need to be in lowercase."
  type        = string
}

variable "project" {
  description = "The name of the project/mission (e.g. europa) deploying the application."
  type        = string
}

variable "region" {
  description = "The AWS region being used to deploy the application."
  type        = string
  default     = "us-west-2"
}

variable "release" {
  description = "The UI release version"
  type        = string
}

variable "service_area" {
  description = "The service area that owns the application/service being deployed."
  type        = string
  default     = "uiux"
}

variable "stack" {
  description = "This should contain the same value as the 'component' variable (tag)."
  type        = string
}

variable "tags" {
  description = "Tags to track key pieces of metadata associated with the deployed Unity UI application."
  type        = map(string)
}

variable "template" {
  default = <<EOT
                  RewriteEngine on
                  ProxyPass /sample http://test-demo-alb-616613476.us-west-2.elb.amazonaws.com:8888/sample/hello.jsp
                  ProxyPassReverse /sample http://test-demo-alb-616613476.us-west-2.elb.amazonaws.com:8888/sample/hello.jsp
EOT
}

variable "venue" {
  description = "The MCP venue in which the Unity UI application will be deployed."
  type        = string
}
