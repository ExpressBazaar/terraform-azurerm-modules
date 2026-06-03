# Container Registry (ACR) Module

Creates an Azure Container Registry. Defaults to Premium with public access disabled and admin user off — pair with managed identity (e.g. AKS `AcrPull` role) for secure image pulls.

## Usage

```hcl
module "acr" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/container-registry?ref=v1.2.0"
  name                = "acrappprod001"
  resource_group_name = module.rg.name
  location            = module.rg.location
  sku                 = "Premium"

  georeplications = [
    { location = "ukwest" }
  ]

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
| admin_enabled                 | bool         | false       | no       |
| public_network_access_enabled | bool         | false       | no       |
| georeplications               | list(object) | []          | no       |
| tags                          | map(string)  | {}          | no       |

## Outputs

| Name         | Description                     |
|--------------|---------------------------------|
| id           | The ID of the registry          |
| name         | The name of the registry        |
| login_server | The login server URL            |
