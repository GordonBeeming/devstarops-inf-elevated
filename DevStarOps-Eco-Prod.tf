resource "azuread_application" "eco-production" {
  display_name = "DevStarOps-Eco-Prod"
}

resource "azuread_service_principal" "eco-production" {
  application_id = "${azuread_application.eco-production.application_id}"
}

resource "azurerm_role_assignment" "shared-storage-production-reader" {
  scope                = data.azurerm_storage_account.shared.id
  role_definition_name = "Reader and Data Access"
  principal_id         = azuread_service_principal.eco-production.object_id
}

resource "azurerm_role_assignment" "rg-production-owner" {
  scope                = data.azurerm_resource_group.production.id
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.eco-production.object_id
}

resource "azuread_application_federated_identity_credential" "eco-production" {
  application_object_id = azuread_application.eco-production.object_id  
  display_name          = "devstarops-edge"
  description           = "Deployments for devstarops-edge"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:DevStarOps/devstarops-edge:environment:prod"
}

output "production_app" {
  value = azuread_application.eco-production.display_name
}

output "production_client_id" {
  value = azuread_application.eco-production.application_id
}
