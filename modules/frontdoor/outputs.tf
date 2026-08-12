output "id" {
  description = "The ID of the Front Door."
  value       = azurerm_front_door.this.id
}

output "name" {
  description = "The name of the Front Door."
  value       = azurerm_front_door.this.name
}

output "host_name" {
  description = "The hostname of the Front Door."
  value       = azurerm_front_door.this.host_name
}
