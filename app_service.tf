resource "azurerm_linux_web_app" "bestrong_app_service" {
  name                = local.names.app_service
  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  service_plan_id     = azurerm_service_plan.bestrong_app_service_plan.id

  identity {
    type = "SystemAssigned" # Enable Managed Identity
  }

  site_config {
    vnet_route_all_enabled = true # Integrated with VNet
  }

  public_network_access_enabled = false

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"             = azurerm_application_insights.bestrong_app_insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING"      = azurerm_application_insights.bestrong_app_insights.connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
    # Mounting Fileshare
    "AZURE_STORAGE_ACCOUNT_NAME" = azurerm_storage_account.bestrong_storage.name
    "AZURE_STORAGE_ACCOUNT_KEY"  = azurerm_storage_account.bestrong_storage.primary_access_key
    "FILES_PATH"                 = azurerm_storage_share.bestrong_fileshare.name
  }


  depends_on = [azurerm_subnet.bestrong_subnet_app]


  tags = local.tags
}

resource "azurerm_private_endpoint" "bestrong_app_service_pe" {
  name                = local.names.app_service_pe
  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  subnet_id           = azurerm_subnet.bestrong_subnet_pe.id

  private_service_connection {
    name                           = local.names.app_service_connection
    private_connection_resource_id = azurerm_linux_web_app.bestrong_app_service.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  tags = local.tags
}





