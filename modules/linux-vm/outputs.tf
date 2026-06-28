output "id" {
  description = "The ID of the Linux virtual machine."
  value       = azurerm_linux_virtual_machine.this.id
}

output "name" {
  description = "The name of the Linux virtual machine."
  value       = azurerm_linux_virtual_machine.this.name
}

output "private_ip_address" {
  description = "The primary private IP address of the VM."
  value       = azurerm_network_interface.this.private_ip_address
}

output "public_ip_address" {
  description = "The public IP address of the VM, if created."
  value       = var.public_ip_enabled ? azurerm_public_ip.this[0].ip_address : null
}

output "network_interface_id" {
  description = "The ID of the VM network interface."
  value       = azurerm_network_interface.this.id
}
