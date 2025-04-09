resource "azurerm_container_registry" "bestrong_acr" {
  name                = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  admin_enabled       = true

  tags = var.tags
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.bestrong_acr.id
  role_definition_name = "AcrPull"
  principal_id         = var.app_service_principal_id
}
