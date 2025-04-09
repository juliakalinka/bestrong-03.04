resource "azurerm_container_registry" "bestrong_acr" {
  name                = local.names.acr
  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  sku                 = "Basic"
  admin_enabled       = false
  tags                = local.tags
}

resource "azurerm_role_assignment" "acr_pull_permission" {
  principal_id         = azurerm_linux_web_app.bestrong_app_service.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.bestrong_acr.id
  depends_on           = [azurerm_container_registry.bestrong_acr]
}
