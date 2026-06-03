output "id" {
  description = "The ID of the web app."
  value       = azurerm_linux_web_app.this.id
}

output "name" {
  description = "The name of the web app."
  value       = azurerm_linux_web_app.this.name
}

output "default_hostname" {
  description = "The default hostname of the web app."
  value       = azurerm_linux_web_app.this.default_hostname
}

output "service_plan_id" {
  description = "The ID of the App Service Plan."
  value       = azurerm_service_plan.this.id
}

output "principal_id" {
  description = "Object ID of the system-assigned identity."
  value       = azurerm_linux_web_app.this.identity[0].principal_id
}
