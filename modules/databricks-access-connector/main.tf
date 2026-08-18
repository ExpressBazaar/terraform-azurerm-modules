resource "azurerm_databricks_access_connector" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  identity {
    type = var.identity_type

    dynamic "user_assigned_identity_id" {
      for_each = var.identity_type == "UserAssigned" ? [var.user_assigned_identity_id] : []
      content {
        value = user_assigned_identity_id.value
      }
    }
  }
}

output "id" {
  description = "The ID of the Databricks access connector."
  value       = azurerm_databricks_access_connector.this.id
}

output "name" {
  description = "The name of the Databricks access connector."
  value       = azurerm_databricks_access_connector.this.name
}

output "principal_id" {
  description = "The principal ID of the managed identity."
  value       = azurerm_databricks_access_connector.this.identity[0].principal_id
}

output "tenant_id" {
  description = "The tenant ID of the managed identity."
  value       = azurerm_databricks_access_connector.this.identity[0].tenant_id
}
