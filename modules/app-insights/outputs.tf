output "id" {
  description = "The ID of the Application Insights instance."
  value       = azurerm_application_insights.this.id
}

output "name" {
  description = "The name of the Application Insights instance."
  value       = azurerm_application_insights.this.name
}

output "app_id" {
  description = "The App ID associated with the Application Insights instance."
  value       = azurerm_application_insights.this.app_id
}

output "instrumentation_key" {
  description = "The instrumentation key for the Application Insights instance."
  value       = azurerm_application_insights.this.instrumentation_key
  sensitive   = true
}

output "connection_string" {
  description = "The connection string for the Application Insights instance."
  value       = azurerm_application_insights.this.connection_string
  sensitive   = true
}
