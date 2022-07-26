data "azurerm_storage_account" "shared" {
  name                = "dsosharedstorage"
  resource_group_name = var.resource_group_name
}
