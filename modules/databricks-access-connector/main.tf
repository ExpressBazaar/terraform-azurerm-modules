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


