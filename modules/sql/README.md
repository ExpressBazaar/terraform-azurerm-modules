# Azure SQL Module

Creates an Azure SQL logical server and one or more databases. Defaults to public access disabled and TLS 1.2, and supports Azure AD administrator (recommended) alongside or instead of SQL authentication. Pair with the `private-dns-zone` module (`privatelink.database.windows.net`) for private connectivity.

## Usage

```hcl
module "sql" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/sql?ref=v1.2.0"
  server_name         = "sql-app-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location

  azuread_administrator = {
    login_username = "sql-admins"
    object_id      = var.sql_admin_group_object_id
  }

  databases = [
    { name = "appdb", sku_name = "S1", max_size_gb = 50 }
  ]

  tags = local.tags
}
```

## Inputs

| Name                          | Type         | Default   | Required |
|-------------------------------|--------------|-----------|----------|
| server_name                   | string       | n/a       | yes      |
| resource_group_name           | string       | n/a       | yes      |
| location                      | string       | n/a       | yes      |
| server_version                | string       | "12.0"    | no       |
| administrator_login           | string       | null      | no       |
| administrator_login_password  | string       | null      | no       |
| azuread_administrator         | object       | null      | no       |
| minimum_tls_version           | string       | "1.2"     | no       |
| public_network_access_enabled | bool         | false     | no       |
| databases                     | list(object) | []        | no       |
| tags                          | map(string)  | {}        | no       |

> Provide either SQL auth (`administrator_login` + password) or `azuread_administrator` (or both). Azure AD-only is the most secure.

## Outputs

| Name         | Description                       |
|--------------|-----------------------------------|
| server_id    | The ID of the SQL server          |
| server_name  | The name of the SQL server        |
| server_fqdn  | The FQDN of the SQL server        |
| database_ids | Map of database name to ID        |
