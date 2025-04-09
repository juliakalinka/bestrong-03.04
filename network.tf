resource "azurerm_virtual_network" "bestrong_vnet" {
  name                = local.names.vnet
  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  address_space       = ["10.0.0.0/16"]
  tags                = local.tags
}

resource "azurerm_subnet" "bestrong_subnet_app" {
  name                 = local.names.subnet_app
  resource_group_name  = azurerm_resource_group.bestrong_rg.name
  virtual_network_name = azurerm_virtual_network.bestrong_vnet.name
  address_prefixes     = ["10.0.1.0/24"]

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
  name                 = local.names.subnet_sql
  resource_group_name  = azurerm_resource_group.bestrong_rg.name
  virtual_network_name = azurerm_virtual_network.bestrong_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "bestrong_subnet_storage" {
  name                 = local.names.subnet_storage
  resource_group_name  = azurerm_resource_group.bestrong_rg.name
  virtual_network_name = azurerm_virtual_network.bestrong_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "bestrong_subnet_kv" {
  name                 = local.names.subnet_kv
  resource_group_name  = azurerm_resource_group.bestrong_rg.name
  virtual_network_name = azurerm_virtual_network.bestrong_vnet.name
  address_prefixes     = ["10.0.4.0/24"]
  service_endpoints    = ["Microsoft.KeyVault"]
}

resource "azurerm_subnet" "bestrong_subnet_pe" {
  name                 = local.names.subnet_app_pe
  resource_group_name  = azurerm_resource_group.bestrong_rg.name
  virtual_network_name = azurerm_virtual_network.bestrong_vnet.name
  address_prefixes     = ["10.0.5.0/24"]
}


resource "azurerm_app_service_virtual_network_swift_connection" "bestrong_vnet_integration" {
  app_service_id = azurerm_linux_web_app.bestrong_app_service.id
  subnet_id      = azurerm_subnet.bestrong_subnet_app.id
}

