resource "azurerm_key_vault" "bestrong_kv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = []
    virtual_network_subnet_ids = [var.subnet_id]
  }

  tags = var.tags
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "kv_secrets_user" {
  scope                = azurerm_key_vault.bestrong_kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.app_service_principal_id
}
