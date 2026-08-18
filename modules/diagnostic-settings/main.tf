locals {
  has_destination = var.log_analytics_workspace_id != null || var.storage_account_id != null || var.eventhub_namespace_id != null
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count              = local.has_destination ? 1 : 0
  name               = var.name
  target_resource_id = var.target_resource_id

  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id          = var.storage_account_id

  dynamic "eventhub_authorization_rule_id" {
    for_each = var.eventhub_namespace_id != null && var.eventhub_policy_name != null ? [var.eventhub_policy_name] : []
    content {
      name = eventhub_authorization_rule_id.value
    }
  }

  dynamic "log" {
    for_each = var.logs
    content {
      category = log.value.category
      retention_policy {
        enabled = log.value.retention_days > 0
        days    = log.value.retention_days
      }
    }
  }

  dynamic "metric" {
    for_each = var.metrics
    content {
      category = metric.value.category
      enabled  = metric.value.enabled

      retention_policy {
        enabled = true
        days    = 0
      }
    }
  }
}
