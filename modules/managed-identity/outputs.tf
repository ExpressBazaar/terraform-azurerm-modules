output "id" {
  description = "The ID of the user-assigned managed identity."
  value       = azurerm_user_assigned_identity.this.id
}

output "name" {
  description = "The name of the user-assigned managed identity."
  value       = azurerm_user_assigned_identity.this.name
}

output "principal_id" {
  description = "The service principal (object) ID, used for role assignments."
  value       = azurerm_user_assigned_identity.this.principal_id
}

output "client_id" {
  description = "The client ID of the identity, used by applications to authenticate."
  value       = azurerm_user_assigned_identity.this.client_id
}

output "tenant_id" {
  description = "The tenant ID of the identity."
  value       = azurerm_user_assigned_identity.this.tenant_id
}
