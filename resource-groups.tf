
resource "azurerm_resource_group" "local" {
  name     = "devstarops-local-rg"
  location = var.deploy_region

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_resource_group" "test" {
  name     = "devstarops-test-rg"
  location = var.deploy_region

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_resource_group" "production" {
  name     = "devstarops-production-rg"
  location = var.deploy_region

  lifecycle {
    prevent_destroy = true
  }
}