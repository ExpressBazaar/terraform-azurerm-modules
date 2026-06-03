# Subnet Module

Creates an Azure Subnet within an existing VNet. Supports service endpoints and delegations.

## Usage

```hcl
module "subnet_web" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/subnet?ref=v1.0.0"
  name                = "snet-web"
  resource_group_name = module.rg.name
  vnet_name           = module.vnet.name
  address_prefixes    = ["10.10.1.0/24"]
  service_endpoints   = ["Microsoft.Storage"]
}
```

## Inputs

| Name                | Type            | Default | Required |
|---------------------|-----------------|---------|----------|
| name                | string          | n/a     | yes      |
| resource_group_name | string          | n/a     | yes      |
| vnet_name           | string          | n/a     | yes      |
| address_prefixes    | list(string)    | n/a     | yes      |
| service_endpoints   | list(string)    | []      | no       |
| delegations         | list(object)    | []      | no       |

## Outputs

| Name             | Description                     |
|------------------|---------------------------------|
| id               | The ID of the subnet            |
| name             | The name of the subnet          |
| address_prefixes | The address prefixes of subnet  |
