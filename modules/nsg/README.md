# Network Security Group (NSG) Module

Creates an Azure NSG with dynamic security rules and an optional subnet association.

## Usage

```hcl
module "nsg_web" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/nsg?ref=v1.0.0"
  name                = "nsg-web"
  resource_group_name = module.rg.name
  location            = module.rg.location
  subnet_id           = module.subnet_web.id

  rules = [
    {
      name                   = "allow-https"
      priority               = 100
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      destination_port_range = "443"
    }
  ]
}
```

## Inputs

| Name                | Type         | Default | Required |
|---------------------|--------------|---------|----------|
| name                | string       | n/a     | yes      |
| resource_group_name | string       | n/a     | yes      |
| location            | string       | n/a     | yes      |
| rules               | list(object) | []      | no       |
| subnet_id           | string       | null    | no       |
| tags                | map(string)  | {}      | no       |

Rule object fields: `name`, `priority`, `direction`, `access`, `protocol`, and optional `source_port_range`, `destination_port_range`, `source_address_prefix`, `destination_address_prefix` (all default to `*`).

## Outputs

| Name | Description           |
|------|-----------------------|
| id   | The ID of the NSG     |
| name | The name of the NSG   |
