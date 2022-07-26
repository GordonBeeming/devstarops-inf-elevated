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
  scope                = data.azurerm_resource_group.test.id
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.eco-test.object_id
}

resource "azuread_directory_role_assignment" "directory-test-reader" {
  role_id             = azuread_directory_role.directory-reader.template_id
  principal_object_id = azuread_service_principal.eco-test.object_id
}

output "test_app" {
  value = azuread_application.eco-test.display_name
}

output "test_client_id" {
  value = azuread_application.eco-test.application_id
}
