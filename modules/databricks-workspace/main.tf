resource "azurerm_databricks_workspace" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  managed_resource_group_name   = "${var.name}-managed-rg"
  public_network_access_enabled = var.public_network_access_enabled
  managed_virtual_network_enabled = var.managed_virtual_network_enabled
  customer_managed_key_id        = var.customer_managed_key_id
  tags                          = var.tags

  dynamic "network_security_group_rules" {
    for_each = var.network_security_group_rules
    content {
      name                         = network_security_group_rules.value.name
      direction                    = network_security_group_rules.value.direction
      access                       = network_security_group_rules.value.access
      priority                     = network_security_group_rules.value.priority
      protocol                     = network_security_group_rules.value.protocol
      source_address_prefix        = network_security_group_rules.value.source_address_prefix
      destination_address_prefix   = network_security_group_rules.value.destination_address_prefix
    }
  }
}
