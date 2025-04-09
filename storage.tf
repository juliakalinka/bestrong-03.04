resource "azurerm_storage_account" "bestrong_storage" {
  name                     = local.names.storage_account
  resource_group_name      = azurerm_resource_group.bestrong_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.bestrong_subnet_storage.id]
    bypass                     = ["AzureServices"]
  }

  tags = local.tags
}

resource "azurerm_storage_share" "bestrong_fileshare" {
  name               = local.names.storage_fileshare
  storage_account_id = azurerm_storage_account.bestrong_storage.id
  quota              = 50 # Storage limit in GB
}

resource "azurerm_private_endpoint" "bestrong_storage_pe" {
  name                = local.names.storage_private_endpoint
  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  subnet_id           = azurerm_subnet.bestrong_subnet_storage.id

  private_service_connection {
    name                           = local.names.storage_service_connection
    private_connection_resource_id = azurerm_storage_account.bestrong_storage.id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }

  tags = local.tags
}

