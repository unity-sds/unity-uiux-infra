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

// Injected by Marketplace
variable "deployment_name" {
  description = "Unique name of this deployment in the account."
  type        = string
}

// Injected by Marketplace
variable "installprefix" {
  description = "The management console install prefix"
  type        = string
}

// Injected by Marketplace
variable "project" {
  description = "The project or mission deploying Unity SPS"
  type        = string
}

// Injected by Marketplace
variable "tags" {
  description = "Tags to be applied to Unity UI resources that support tags"
  type        = map(string)
}

variable "additional_tags" {
  description = "Additional Resource Tags"
  type        = map(string)
  default     = {
    Venue = "dev"
    ServiceArea = "uiux"
    CapVersion = "0.8.0"
    Component = "navbar"
    Proj = "Unity"
    CreatedBy = "uiux"
    Env = "dev"
    Stack = "ui"
  }
}

// Injected by Marketplace
variable "venue" {
  description = "The MCP venue in which the cluster will be deployed (dev, test, prod)"
  type        = string
}