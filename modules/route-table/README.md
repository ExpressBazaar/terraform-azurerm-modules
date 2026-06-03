# Route Table Module

Creates an Azure Route Table with dynamic routes and an optional subnet association.

## Usage

```hcl
module "rt" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/route-table?ref=v1.0.0"
  name                = "rt-web"
  resource_group_name = module.rg.name
  location            = module.rg.location
  subnet_id           = module.subnet_web.id

  routes = [
    {
      name                   = "to-firewall"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.10.0.4"
    }
  ]
}
```

## Inputs

| Name                          | Type         | Default | Required |
|-------------------------------|--------------|---------|----------|
| name                          | string       | n/a     | yes      |
| resource_group_name           | string       | n/a     | yes      |
| location                      | string       | n/a     | yes      |
| bgp_route_propagation_enabled | bool         | true    | no       |
| routes                        | list(object) | []      | no       |
| subnet_id                     | string       | null    | no       |
| tags                          | map(string)  | {}      | no       |

## Outputs

| Name | Description                  |
|------|------------------------------|
| id   | The ID of the route table    |
| name | The name of the route table  |
