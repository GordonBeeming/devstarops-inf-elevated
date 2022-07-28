resource "azuread_application" "eco-local" {
  display_name = "DevStarOps-Eco-Local"
}

resource "azuread_service_principal" "eco-local" {
  application_id = "${azuread_application.eco-local.application_id}"
}

resource "azurerm_role_assignment" "shared-storage-local-reader" {
  scope                = data.azurerm_storage_account.shared.id
  role_definition_name = "Reader and Data Access"
  principal_id         = azuread_service_principal.eco-local.object_id
}

resource "azurerm_role_assignment" "rg-local-owner" {
  scope                = azurerm_resource_group.local.id
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.eco-local.object_id
}

resource "azuread_application_federated_identity_credential" "eco-local-edge" {
  application_object_id = azuread_application.eco-local.object_id
  display_name          = "devstarops-edge"
  description           = "Deployments for devstarops-edge"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:DevStarOps/devstarops-edge:environment:local"
}

resource "azuread_application_federated_identity_credential" "eco-local-profile" {
  application_object_id = azuread_application.eco-local.object_id
  display_name          = "devstarops-profile"
  description           = "Deployments for devstarops-profile"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:DevStarOps/devstarops-profile:environment:local"
}

output "local_app" {
  value = azuread_application.eco-local.display_name
}

output "local_client_id" {
  value = azuread_application.eco-local.application_id
}
