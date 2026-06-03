output "id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "The name of the storage account."
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "The primary blob service endpoint."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "container_names" {
  description = "Names of the created containers."
  value       = [for c in azurerm_storage_container.this : c.name]
}
