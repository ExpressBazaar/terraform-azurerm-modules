output "id" {
  description = "The ID of the Container App Environment."
  value       = azurerm_container_app_environment.this.id
}

output "name" {
  description = "The name of the Container App Environment."
  value       = azurerm_container_app_environment.this.name
}

output "default_domain" {
  description = "The default, publicly resolvable domain of the environment."
  value       = azurerm_container_app_environment.this.default_domain
}

output "static_ip_address" {
  description = "The static IP address of the environment."
  value       = azurerm_container_app_environment.this.static_ip_address
}

output "docker_bridge_cidr" {
  description = "The network address of the Docker bridge network."
  value       = azurerm_container_app_environment.this.docker_bridge_cidr
}
