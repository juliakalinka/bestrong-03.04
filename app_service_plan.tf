resource "azurerm_service_plan" "bestrong_app_service_plan" {
  name                = local.names.app_service_plan
  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  os_type             = "Linux"
  sku_name            = "S1" # Базовий план для App Service

  tags = local.tags
}

