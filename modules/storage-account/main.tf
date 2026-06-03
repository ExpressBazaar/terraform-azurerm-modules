resource "azurerm_storage_account" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  account_kind                  = var.account_kind
  min_tls_version               = var.min_tls_version
  https_traffic_only_enabled    = var.https_traffic_only_enabled
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags

  blob_properties {
    versioning_enabled = var.blob_versioning_enabled
    delete_retention_policy {
      days = var.blob_soft_delete_retention_days
    }
  }

  dynamic "network_rules" {
    for_each = var.network_rules == null ? [] : [var.network_rules]
    content {
      default_action             = network_rules.value.default_action
      bypass                     = network_rules.value.bypass
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
    }
  }
}

resource "azurerm_storage_container" "this" {
  for_each              = { for c in var.containers : c.name => c }
  name                  = each.value.name
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = each.value.access_type
}
