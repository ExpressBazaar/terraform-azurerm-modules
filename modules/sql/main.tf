resource "azurerm_mssql_server" "this" {
  name                          = var.server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.server_version
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags

  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator == null ? [] : [var.azuread_administrator]
    content {
      login_username = azuread_administrator.value.login_username
      object_id      = azuread_administrator.value.object_id
      tenant_id      = azuread_administrator.value.tenant_id
    }
  }
}

resource "azurerm_mssql_database" "this" {
  for_each       = { for db in var.databases : db.name => db }
  name           = each.value.name
  server_id      = azurerm_mssql_server.this.id
  sku_name       = each.value.sku_name
  max_size_gb    = each.value.max_size_gb
  collation      = each.value.collation
  zone_redundant = each.value.zone_redundant
  tags           = var.tags
}
