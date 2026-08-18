output "id" {
  description = "The ID of the private endpoint."
  value       = azurerm_private_endpoint.this.id
}

output "name" {
  description = "The name of the private endpoint."
  value       = azurerm_private_endpoint.this.name
}

output "private_service_connection_name" {
  description = "The name of the private service connection."
  value       = azurerm_private_endpoint.this.private_service_connection[0].name
}

output "network_interface_ids" {
  description = "The list of network interface IDs."
  value       = azurerm_private_endpoint.this.network_interface_ids
}
