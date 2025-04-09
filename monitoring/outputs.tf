output "app_insights_id" {
  description = "ID of the Application Insights"
  value       = azurerm_application_insights.bestrong_app_insights.id
}

output "app_insights_name" {
  description = "Name of the Application Insights"
  value       = azurerm_application_insights.bestrong_app_insights.name
}

output "instrumentation_key" {
  description = "Instrumentation key for Application Insights"
  value       = azurerm_application_insights.bestrong_app_insights.instrumentation_key
}

output "connection_string" {
  description = "Connection string for Application Insights"
  value       = azurerm_application_insights.bestrong_app_insights.connection_string
}
