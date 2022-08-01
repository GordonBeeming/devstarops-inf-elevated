resource "azuread_application" "eco-test" {
  display_name = "DevStarOps-Eco-Test"
}

resource "azuread_service_principal" "eco-test" {
  application_id = "${azuread_application.eco-test.application_id}"
}

resource "azurerm_role_assignment" "shared-storage-test-reader" {
  scope                = data.azurerm_storage_account.shared.id
  role_definition_name = "Reader and Data Access"
  principal_id         = azuread_service_principal.eco-test.object_id
}

resource "azurerm_role_assignment" "rg-test-owner" {
  scope                = azurerm_resource_group.test.id
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.eco-test.object_id
}

resource "azuread_application_federated_identity_credential" "eco-test-edge" {
  application_object_id = azuread_application.eco-test.object_id
  display_name          = "devstarops-edge"
  description           = "Deployments for devstarops-edge"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:DevStarOps/devstarops-edge:environment:test"
}

resource "azuread_application_federated_identity_credential" "eco-test-profile" {
  application_object_id = azuread_application.eco-test.object_id
  display_name          = "devstarops-profile"
  description           = "Deployments for devstarops-profile"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:DevStarOps/devstarops-profile:environment:test"
}

resource "azuread_service_principal_password" "eco-test" {
  service_principal_id = azuread_service_principal.eco-test.id
  end_date_relative    = "2400h30m"
}

output "test_app" {
  value = azuread_application.eco-test.display_name
}

output "test_client_id" {
  value = azuread_application.eco-test.application_id
}
