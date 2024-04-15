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
