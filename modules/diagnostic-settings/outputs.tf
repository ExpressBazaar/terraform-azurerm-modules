output "id" {
  description = "The ID of the diagnostic setting."
  value       = azurerm_monitor_diagnostic_setting.this != null ? azurerm_monitor_diagnostic_setting.this[0].id : null
}

output "name" {
  description = "The name of the diagnostic setting."
  value       = azurerm_monitor_diagnostic_setting.this != null ? azurerm_monitor_diagnostic_setting.this[0].name : null
}
