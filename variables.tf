variable "deploy_region" {
  type = string
  default = "westeurope"
}

variable "resource_group_name" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "github_token" {
  type = string
  sensitive = true
}
