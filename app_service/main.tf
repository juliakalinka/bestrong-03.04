resource "azurerm_service_plan" "bestrong_app_service_plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.app_service_plan_sku

  tags = var.tags
}

resource "azurerm_linux_web_app" "bestrong_app_service" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.bestrong_app_service_plan.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    vnet_route_all_enabled = true
  }

  public_network_access_enabled = false

  storage_account {
    name         = "fileshare"
    type         = "AzureFiles"
    account_name = var.storage_account_name
    share_name   = var.fileshare_name
    access_key   = var.storage_account_key
    mount_path   = "/mnt/fileshare"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"             = var.app_insights_instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING"      = var.app_insights_connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "bestrong_app_service_pe" {
  name                = var.app_service_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = var.app_service_connection_name
    private_connection_resource_id = azurerm_linux_web_app.bestrong_app_service.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "bestrong_vnet_integration" {
  app_service_id = azurerm_linux_web_app.bestrong_app_service.id
  subnet_id      = var.app_subnet_id
}
