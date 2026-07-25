output "id" {
  description = "The ID of the container registry."
  value       = azurerm_container_registry.this.id
}

output "name" {
  description = "The name of the container registry."
  value       = azurerm_container_registry.this.name
}

output "login_server" {
  description = "The login server URL of the registry."
  value       = azurerm_container_registry.this.login_server
}
