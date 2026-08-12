output "application_id" {
  description = "The application ID (client ID)."
  value       = azuread_application.this.application_id
}

output "object_id" {
  description = "The object ID of the application."
  value       = azuread_application.this.object_id
}

output "service_principal_object_id" {
  description = "The object ID of the service principal."
  value       = azuread_service_principal.this.object_id
}

output "service_principal_application_id" {
  description = "The application ID of the service principal."
  value       = azuread_service_principal.this.application_id
}

output "client_secret" {
  description = "The generated client secret."
  value       = azuread_service_principal_password.this.value
  sensitive   = true
}
