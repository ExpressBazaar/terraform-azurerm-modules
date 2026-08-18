output "id" {
  description = "The ID of the Databricks access connector."
  value       = azurerm_databricks_access_connector.this.id
}

output "name" {
  description = "The name of the Databricks access connector."
  value       = azurerm_databricks_access_connector.this.name
}

output "principal_id" {
  description = "The principal ID of the managed identity."
  value       = azurerm_databricks_access_connector.this.identity[0].principal_id
}

output "tenant_id" {
  description = "The tenant ID of the managed identity."
  value       = azurerm_databricks_access_connector.this.identity[0].tenant_id
}
