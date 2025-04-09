resource "azurerm_key_vault" "bestrong_kv" {
  name                      = local.names.key_vault
  location                  = var.location
  resource_group_name       = azurerm_resource_group.bestrong_rg.name
  tenant_id                 = var.tenant_id
  sku_name                  = "standard"
  purge_protection_enabled  = true
  enable_rbac_authorization = true
  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    virtual_network_subnet_ids = [azurerm_subnet.bestrong_subnet_kv.id]
  }

  tags = local.tags
}

resource "azurerm_role_assignment" "kv_access" {
  scope                = azurerm_key_vault.bestrong_kv.id
  role_definition_name = "Key Vault Reader"
  principal_id         = azurerm_linux_web_app.bestrong_app_service.identity[0].principal_id

  depends_on = [azurerm_key_vault.bestrong_kv]
}

resource "azurerm_private_endpoint" "kv_pe" {
  name                = local.names.key_vault_pe
  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  subnet_id           = azurerm_subnet.bestrong_subnet_kv.id

  private_service_connection {
    name                           = local.names.key_vault_connection
    private_connection_resource_id = azurerm_key_vault.bestrong_kv.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  tags = local.tags
}

