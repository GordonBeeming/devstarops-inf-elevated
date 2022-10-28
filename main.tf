terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }

  required_version = "= 1.3.2"

  backend "azurerm" {}
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "shared" {
  name = var.resource_group_name
}

# Configure the GitHub Provider
provider "github" {
  token = var.github_token
}

data "github_user" "current" {
  username = "devstarops"
}

output "shared_resource_group" {
  value = data.azurerm_resource_group.shared.name
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}