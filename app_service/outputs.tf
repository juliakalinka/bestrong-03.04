output "app_service_id" {
  description = "ID of the App Service"
  value       = azurerm_linux_web_app.bestrong_app_service.id
}

output "app_service_name" {
  description = "Name of the App Service"
  value       = azurerm_linux_web_app.bestrong_app_service.name
}

output "app_service_plan_id" {
  description = "ID of the App Service Plan"
  value       = azurerm_service_plan.bestrong_app_service_plan.id
}

output "app_service_identity" {
  description = "Managed Identity of the App Service"
  value       = azurerm_linux_web_app.bestrong_app_service.identity
}

output "app_service_identity_principal_id" {
  description = "Principal ID of the App Service Managed Identity"
  value       = azurerm_linux_web_app.bestrong_app_service.identity[0].principal_id
}
