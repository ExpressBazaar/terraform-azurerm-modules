# Databricks Workspace Module

Creates an Azure Databricks workspace with secure defaults. Use with private endpoints and Unity Catalog access connector for production isolation.

## Usage

```hcl
module "databricks_workspace" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/databricks-workspace?ref=v1.2.0"
  name                = "dbw-prod-001"
  resource_group_name = module.rg.name
  location            = module.rg.location
  sku                 = "Premium"
  public_network_access_enabled = false

  managed_virtual_network_enabled = true

  tags = local.tags
}
```

## Inputs

| Name                          | Type         | Default     | Required |
|-------------------------------|--------------|-------------|----------|
| name                          | string       | n/a         | yes      |
| resource_group_name           | string       | n/a         | yes      |
| location                      | string       | n/a         | yes      |
| sku                           | string       | "Premium"   | no       |
| public_network_access_enabled | bool         | false       | no       |
| managed_virtual_network_enabled | bool       | true        | no       |
| customer_managed_key_id       | string       | null        | no       |
| network_security_group_rules  | list(object) | []          | no       |
| tags                          | map(string)  | {}          | no       |

## Outputs

| Name                      | Description                          |
|---------------------------|--------------------------------------|
| id                        | The ID of the workspace              |
| name                      | The name of the workspace            |
| workspace_url             | The URL of the workspace             |
| managed_resource_group_id | The ID of the managed resource group |
