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

variable "test_frontdoor_admin_user" {
  type = string
  sensitive = true
}
variable "test_frontdoor_admin_password" {
  type = string
  sensitive = true
}
variable "production_frontdoor_admin_user" {
  type = string
  sensitive = true
}
variable "production_frontdoor_admin_password" {
  type = string
  sensitive = true
}

variable "test_app1_admin_user" {
  type = string
  sensitive = true
}
variable "test_app1_admin_password" {
  type = string
  sensitive = true
}
variable "production_app1_admin_user" {
  type = string
  sensitive = true
}
variable "production_app1_admin_password" {
  type = string
  sensitive = true
}

variable "cloudflare_api_token" {
  type = string
  sensitive = true
}

variable "cloudflare_service_key" {
  type = string
  sensitive = true
}

variable "cloudflare_zone_id" {
  type = string
}

variable "snyk_token" {
  type = string
}
