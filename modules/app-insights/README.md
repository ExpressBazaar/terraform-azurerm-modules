# Application Insights Module

Creates an Azure Application Insights instance for application performance monitoring and telemetry. Defaults to workspace-based mode — pass a Log Analytics workspace ID (classic, workspace-less mode is retired).

## Usage

```hcl
module "app_insights" {
  source              = "git::https://github.com/ExpressBazaar/terraform-azurerm-modules.git//modules/app-insights?ref=v1.2.0"
  name                = "appi-app-prod-001"
  resource_group_name = module.rg.name
  location            = module.rg.location
  application_type    = "web"
  workspace_id        = module.log_analytics.id

  retention_in_days   = 90
  sampling_percentage = 100

  tags = local.tags
}
```

## Inputs

| Name                 | Type        | Default | Required |
|----------------------|-------------|---------|----------|
| name                 | string      | n/a     | yes      |
| resource_group_name  | string      | n/a     | yes      |
| location             | string      | n/a     | yes      |
| application_type     | string      | "web"   | no       |
| workspace_id         | string      | null    | no       |
| retention_in_days    | number      | 90      | no       |
| sampling_percentage  | number      | 100     | no       |
| daily_data_cap_in_gb | number      | null    | no       |
| disable_ip_masking   | bool        | false   | no       |
| tags                 | map(string) | {}      | no       |

## Outputs

| Name                | Description                                       | Sensitive |
|---------------------|---------------------------------------------------|-----------|
| id                  | The ID of the Application Insights instance       | no        |
| name                | The name of the Application Insights instance     | no        |
| app_id              | The App ID of the instance                        | no        |
| instrumentation_key | The instrumentation key                           | yes       |
| connection_string   | The connection string (preferred over the key)    | yes       |
