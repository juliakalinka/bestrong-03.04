output "storage_account_id" {
  description = "ID of the Storage Account"
  value       = azurerm_storage_account.bestrong_storage.id
}

output "storage_account_name" {
  description = "Name of the Storage Account"
  value       = azurerm_storage_account.bestrong_storage.name
}

output "storage_account_key" {
  description = "Primary access key of the Storage Account"
  value       = azurerm_storage_account.bestrong_storage.primary_access_key
  sensitive   = true
}

output "fileshare_name" {
  description = "Name of the File Share"
  value       = azurerm_storage_share.bestrong_fileshare.name
}
