output "id" {
  description = "The ID of the Front Door security policy."
  value       = azurerm_cdn_frontdoor_security_policy.this.id
}

output "name" {
  description = "The name of the Front Door security policy."
  value       = azurerm_cdn_frontdoor_security_policy.this.name
}
