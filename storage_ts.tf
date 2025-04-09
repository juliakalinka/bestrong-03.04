resource "azurerm_storage_account" "terraform_state_storage" {
  name                     = local.names.terraform_state_account
  resource_group_name      = azurerm_resource_group.bestrong_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = "Terraform"
  }
}

resource "azurerm_storage_container" "tfstate_container" {
  name                  = local.names.terraform_state_container
  storage_account_id    = azurerm_storage_account.terraform_state_storage.id
  container_access_type = "private"
}
