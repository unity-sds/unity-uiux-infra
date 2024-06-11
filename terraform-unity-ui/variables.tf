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
  description = "The region in which region scoped services should be deployed."
  type        = string
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
