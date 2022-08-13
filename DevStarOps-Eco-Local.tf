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

output "local_app" {
  value = azuread_application.eco-local.display_name
}

output "local_client_id" {
  value = azuread_application.eco-local.application_id
}
