output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.bestrong_vnet.id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.bestrong_vnet.name
}

output "subnet_app_id" {
  description = "ID of the App Service subnet"
  value       = azurerm_subnet.bestrong_subnet_app.id
}

output "subnet_sql_id" {
  description = "ID of the SQL subnet"
  value       = azurerm_subnet.bestrong_subnet_sql.id
}

output "subnet_storage_id" {
  description = "ID of the Storage subnet"
  value       = azurerm_subnet.bestrong_subnet_storage.id
}

output "subnet_kv_id" {
  description = "ID of the Key Vault subnet"
  value       = azurerm_subnet.bestrong_subnet_kv.id
}

output "subnet_pe_id" {
  description = "ID of the Private Endpoint subnet"
  value       = azurerm_subnet.bestrong_subnet_pe.id
}
