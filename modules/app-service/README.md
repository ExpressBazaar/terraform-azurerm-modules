# App Service Module (Linux Web App)

Creates a Linux App Service Plan and Web App with a system-assigned identity, HTTPS-only, TLS 1.2, optional regional VNet integration, and a configurable runtime stack (container image, .NET, Node, or Python).

## Usage

```hcl
module "app" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/app-service?ref=v1.2.0"
  name                = "app-web-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
  service_plan_name   = "asp-web-prod"
  sku_name            = "P1v3"

  application_stack = {
    node_version = "20-lts"
  }

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }

  vnet_integration_subnet_id = module.subnet_app.id
  tags                       = local.tags
}
```

## Inputs

| Name                       | Type        | Default   | Required |
|----------------------------|-------------|-----------|----------|
| name                       | string      | n/a       | yes      |
| resource_group_name        | string      | n/a       | yes      |
| location                   | string      | n/a       | yes      |
| service_plan_name          | string      | n/a       | yes      |
| sku_name                   | string      | "P1v3"    | no       |
| os_type                    | string      | "Linux"   | no       |
| worker_count               | number      | 1         | no       |
| application_stack          | object      | {}        | no       |
| app_settings               | map(string) | {}        | no       |
| https_only                 | bool        | true      | no       |
| vnet_integration_subnet_id | string      | null      | no       |
| minimum_tls_version        | string      | "1.2"     | no       |
| tags                       | map(string) | {}        | no       |

> The VNet integration subnet must be delegated to `Microsoft.Web/serverFarms` — use the subnet module's `delegations` input.

## Outputs

| Name             | Description                       |
|------------------|-----------------------------------|
| id               | The ID of the web app             |
| name             | The name of the web app           |
| default_hostname | The default hostname              |
| service_plan_id  | The ID of the App Service Plan    |
| principal_id     | System-assigned identity object ID|
