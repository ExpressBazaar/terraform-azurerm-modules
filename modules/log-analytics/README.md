# Log Analytics Workspace Module

Creates an Azure Log Analytics workspace with configurable retention, a daily ingestion cap, and optional solutions (e.g. ContainerInsights for AKS). Use its `id` as the destination for diagnostic settings across other resources.

## Usage

```hcl
module "log_analytics" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/log-analytics?ref=v1.1.0"
  name                = "log-app-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
  retention_in_days   = 90

  solutions = [
    {
      solution_name = "ContainerInsights"
      publisher     = "Microsoft"
      product       = "OMSGallery/ContainerInsights"
    }
  ]

  tags = local.tags
}
```

## Inputs

| Name                | Type         | Default      | Required |
|---------------------|--------------|--------------|----------|
| name                | string       | n/a          | yes      |
| resource_group_name | string       | n/a          | yes      |
| location            | string       | n/a          | yes      |
| sku                 | string       | "PerGB2018"  | no       |
| retention_in_days   | number       | 30           | no       |
| daily_quota_gb      | number       | -1           | no       |
| solutions           | list(object) | []           | no       |
| tags                | map(string)  | {}           | no       |

## Outputs

| Name               | Description                            |
|--------------------|----------------------------------------|
| id                 | The ID of the workspace                |
| name               | The name of the workspace              |
| workspace_id       | The customer ID used by agents         |
| primary_shared_key | Primary shared key (sensitive)         |
