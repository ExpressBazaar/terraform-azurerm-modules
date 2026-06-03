# Virtual Network (VNet) Module

Creates an Azure Virtual Network.

## Usage

```hcl
module "vnet" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/vnet?ref=v1.0.0"
  name                = "vnet-app-dev"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.10.0.0/16"]
  tags                = { environment = "dev" }
}
```

## Inputs

| Name                | Type         | Default | Required |
|---------------------|--------------|---------|----------|
| name                | string       | n/a     | yes      |
| resource_group_name | string       | n/a     | yes      |
| location            | string       | n/a     | yes      |
| address_space       | list(string) | n/a     | yes      |
| dns_servers         | list(string) | []      | no       |
| tags                | map(string)  | {}      | no       |

## Outputs

| Name                | Description                       |
|---------------------|-----------------------------------|
| id                  | The ID of the VNet                |
| name                | The name of the VNet              |
| address_space       | The address space of the VNet     |
| resource_group_name | The RG the VNet belongs to        |
