resource "azurerm_virtual_network" "bestrong_vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "bestrong_subnet_app" {
  name                 = var.subnet_app_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.bestrong_vnet.name
  address_prefixes     = var.subnet_app_address_prefixes

  delegation {
    name = "appservice_delegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

resource "azurerm_subnet" "bestrong_subnet_sql" {
  name                 = var.subnet_sql_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.bestrong_vnet.name
  address_prefixes     = var.subnet_sql_address_prefixes
}

resource "azurerm_subnet" "bestrong_subnet_storage" {
  name                 = var.subnet_storage_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.bestrong_vnet.name
  address_prefixes     = var.subnet_storage_address_prefixes
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "bestrong_subnet_kv" {
  name                 = var.subnet_kv_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.bestrong_vnet.name
  address_prefixes     = var.subnet_kv_address_prefixes
  service_endpoints    = ["Microsoft.KeyVault"]
}

resource "azurerm_subnet" "bestrong_subnet_pe" {
  name                 = var.subnet_pe_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.bestrong_vnet.name
  address_prefixes     = var.subnet_pe_address_prefixes
}
