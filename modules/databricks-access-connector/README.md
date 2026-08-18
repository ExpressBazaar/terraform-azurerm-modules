# Databricks Access Connector (Unity Catalog) Module

Creates a Unity Catalog access connector for Azure Databricks. The access connector provides a managed identity that can be granted access to Unity Catalog metastores and storage accounts.

## Usage

```hcl
module "databricks_access_connector" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/databricks-access-connector?ref=v1.2.0"
  name                = "dbac-prod-001"
  resource_group_name = module.rg.name
  location            = module.rg.location

  tags = local.tags
}
```

## Usage with User-Assigned Identity

```hcl
module "databricks_access_connector" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/databricks-access-connector?ref=v1.2.0"
  name                = "dbac-prod-001"
  resource_group_name = module.rg.name
  location            = module.rg.location
  identity_type       = "UserAssigned"
  user_assigned_identity_id = module.user_assigned_identity.id

  tags = local.tags
}
```

## Inputs

| Name                          | Type         | Default     | Required |
|-------------------------------|--------------|-------------|----------|
| name                          | string       | n/a         | yes      |
| resource_group_name           | string       | n/a         | yes      |
| location                      | string       | n/a         | yes      |
| identity_type                 | string       | "SystemAssigned" | no  |
| user_assigned_identity_id     | string       | null        | no       |
| tags                          | map(string)  | {}          | no       |

## Outputs

| Name         | Description                              |
|--------------|------------------------------------------|
| id           | The ID of the access connector           |
| name         | The name of the access connector         |
| principal_id | The principal ID of the managed identity |
| tenant_id    | The tenant ID of the managed identity    |
