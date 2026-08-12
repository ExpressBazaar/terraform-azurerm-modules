# Private Endpoint Module

Creates an Azure Private Endpoint with optional Private DNS Zone group association.

## Usage

```hcl
module "private_endpoint" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/private-endpoint?ref=v1.2.0"
  name                = "pe-storage-account"
  resource_group_name = module.rg.name
  location            = module.rg.location
  subnet_id           = module.subnet_private.id
  target_resource_id  = module.storage_account.id
  subresource_names   = ["blob"]

  private_dns_zone_ids = [azurerm_private_dns_zone.blob.id]
  tags                 = local.tags
}
```

## Inputs

| Name                     | Type             | Default | Required |
|--------------------------|------------------|---------|----------|
| name                     | string           | n/a     | yes      |
| location                 | string           | n/a     | yes      |
| resource_group_name      | string           | n/a     | yes      |
| subnet_id                | string           | n/a     | yes      |
| target_resource_id       | string           | n/a     | yes      |
| private_dns_zone_group_name | string         | null    | no       |
| private_dns_zone_ids     | list(string)     | []      | no       |
| subresource_names        | list(string)     | []      | no       |
| tags                     | map(string)      | {}      | no       |

## Outputs

| Name                      | Description                      |
|---------------------------|----------------------------------|
| id                        | The ID of the private endpoint   |
| name                      | The name of the private endpoint |
| private_service_connection_name | The connection name        |
| network_interface_ids     | The list of NIC IDs              |
