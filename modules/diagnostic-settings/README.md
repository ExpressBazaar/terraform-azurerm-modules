# Diagnostic Settings Module

Creates diagnostic settings for an Azure resource to route logs and metrics to Log Analytics, storage, or Event Hub.

## Usage

```hcl
module "diagnostic_settings" {
  source                      = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/diagnostic-settings?ref=v1.2.0"
  name                        = "diag-myapp-prod"
  target_resource_id          = module.key_vault.id
  log_analytics_workspace_id  = module.log_analytics.id

  logs = [
    {
      category       = "AuditEvent"
      retention_days = 30
    }
  ]

  metrics = [
    {
      category = "AllMetrics"
    }
  ]
}
```

## Inputs

| Name                    | Type           | Default | Required |
|-------------------------|----------------|---------|----------|
| name                    | string         | n/a     | yes      |
| target_resource_id      | string         | n/a     | yes      |
| log_analytics_workspace_id | string      | null    | no       |
| storage_account_id      | string         | null    | no       |
| eventhub_namespace_id   | string         | null    | no       |
| eventhub_policy_name    | string         | null    | no       |
| logs                    | list(object)   | []      | no       |
| metrics                 | list(object)   | []      | no       |
| tags                    | map(string)    | {}      | no       |

## Outputs

| Name | Description |
|------|-------------|
| id   | The ID of the diagnostic setting |
| name | The name of the diagnostic setting |
