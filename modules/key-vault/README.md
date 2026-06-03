# Key Vault Module

Creates an Azure Key Vault with RBAC authorization, purge protection, and a network firewall (default-deny). Designed to pair with the `private-dns-zone` module and a private endpoint.

## Usage

```hcl
module "key_vault" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/key-vault?ref=v1.1.0"
  name                = "kv-app-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

  network_acls = {
    default_action             = "Deny"
    virtual_network_subnet_ids = [module.subnet_app.id]
  }

  tags = local.tags
}
```

## Inputs

| Name                          | Type        | Default          | Required |
|-------------------------------|-------------|------------------|----------|
| name                          | string      | n/a              | yes      |
| resource_group_name           | string      | n/a              | yes      |
| location                      | string      | n/a              | yes      |
| tenant_id                     | string      | n/a              | yes      |
| sku_name                      | string      | "standard"       | no       |
| enable_rbac_authorization     | bool        | true             | no       |
| purge_protection_enabled      | bool        | true             | no       |
| soft_delete_retention_days    | number      | 90               | no       |
| public_network_access_enabled | bool        | false            | no       |
| network_acls                  | object      | default-deny     | no       |
| tags                          | map(string) | {}               | no       |

## Outputs

| Name      | Description                       |
|-----------|-----------------------------------|
| id        | The ID of the Key Vault           |
| name      | The name of the Key Vault         |
| vault_uri | The URI for accessing secrets     |
