# Private DNS Zone Module

Creates an Azure Private DNS zone with VNet links and optional A records. Essential for private endpoints (Key Vault, Storage, SQL) so that the public hostname resolves to the private IP inside your VNet.

## Usage

```hcl
module "private_dns_kv" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/private-dns-zone?ref=v1.1.0"
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = module.rg.name

  virtual_network_links = [
    {
      name               = "link-to-app-vnet"
      virtual_network_id = module.vnet.id
    }
  ]

  tags = local.tags
}
```

## Common Private Link zone names

| Service     | Zone name                              |
|-------------|----------------------------------------|
| Key Vault   | privatelink.vaultcore.azure.net        |
| Blob        | privatelink.blob.core.windows.net      |
| SQL         | privatelink.database.windows.net       |
| ACR         | privatelink.azurecr.io                 |

## Inputs

| Name                  | Type         | Default | Required |
|-----------------------|--------------|---------|----------|
| name                  | string       | n/a     | yes      |
| resource_group_name   | string       | n/a     | yes      |
| virtual_network_links | list(object) | []      | no       |
| a_records             | list(object) | []      | no       |
| tags                  | map(string)  | {}      | no       |

## Outputs

| Name | Description                    |
|------|--------------------------------|
| id   | The ID of the DNS zone         |
| name | The name of the DNS zone       |
