resource "azurerm_application_insights" "bestrong_app_insights" {
  name                = local.names.app_insights
  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  application_type    = "web"
  tags                = local.tags
}

