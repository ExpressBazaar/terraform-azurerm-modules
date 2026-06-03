output "server_id" {
  description = "The ID of the SQL server."
  value       = azurerm_mssql_server.this.id
}

output "server_name" {
  description = "The name of the SQL server."
  value       = azurerm_mssql_server.this.name
}

output "server_fqdn" {
  description = "The fully qualified domain name of the SQL server."
  value       = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "database_ids" {
  description = "Map of database name to ID."
  value       = { for k, db in azurerm_mssql_database.this : k => db.id }
}
