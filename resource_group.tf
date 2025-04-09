resource "azurerm_resource_group" "bestrong_rg" {
  name     = local.names.resource_group
  location = var.location
  tags     = local.tags
}
