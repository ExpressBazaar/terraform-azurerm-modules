# Application Insights Module

Creates an Application Insights component with optional Log Analytics workspace integration.

## Usage

```hcl
module "app_insights" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/application-insights?ref=v1.2.0"
  name                = "appi-myapp-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
  workspace_id        = module.log_analytics.id
  retention_in_days   = 30
  tags                = local.tags
}
```

## Inputs

| Name                     | Type        | Default | Required |
|--------------------------|-------------|---------|----------|
| name                     | string      | n/a     | yes      |
| resource_group_name      | string      | n/a     | yes      |
| location                 | string      | n/a     | yes      |
| workspace_id             | string      | null    | no       |
| retention_in_days        | number      | 30      | no       |
| sampling_percentage      | number      | 100     | no       |
| disable_ip_masking       | bool        | false   | no       |
| tags                     | map(string) | {}      | no       |

## Outputs

| Name                  | Description                      |
|-----------------------|----------------------------------|
| id                    | The ID of the component          |
| name                  | The name of the component        |
| instrumentation_key   | The instrumentation key          |
| connection_string     | The connection string            |
| app_id                | The app ID                       |
