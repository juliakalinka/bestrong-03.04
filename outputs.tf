output "resource_group_name" {
  value = azurerm_resource_group.bestrong_rg.name
}

output "vnet_name" {
  value = module.network.vnet_name
}