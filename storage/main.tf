resource "azurerm_storage_account" "bestrong_storage" {
  name                     = var.storage_account_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [var.subnet_id]
  }

  tags = var.tags
}

resource "azurerm_storage_share" "bestrong_fileshare" {
  name                 = var.fileshare_name
  storage_account_id = azurerm_storage_account.bestrong_storage.id
  quota                = 50
}

resource "azurerm_private_endpoint" "storage_pe" {
  name                = var.storage_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = var.storage_connection_name
    private_connection_resource_id = azurerm_storage_account.bestrong_storage.id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }

  tags = var.tags
}
