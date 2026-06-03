# Storage Account Module

Creates an Azure Storage Account (StorageV2) with secure defaults: TLS 1.2, HTTPS-only, public access disabled, blob versioning and soft-delete, an optional network firewall, and optional containers.

## Usage

```hcl
module "storage" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/storage-account?ref=v1.1.0"
  name                = "stappprod001"
  resource_group_name = module.rg.name
  location            = module.rg.location

  containers = [
    { name = "uploads" },
    { name = "logs" }
  ]

  network_rules = {
    default_action             = "Deny"
    virtual_network_subnet_ids = [module.subnet_app.id]
  }

  tags = local.tags
}
```

## Inputs

| Name                            | Type         | Default     | Required |
|---------------------------------|--------------|-------------|----------|
| name                            | string       | n/a         | yes      |
| resource_group_name             | string       | n/a         | yes      |
| location                        | string       | n/a         | yes      |
| account_tier                    | string       | "Standard"  | no       |
| account_replication_type        | string       | "ZRS"       | no       |
| account_kind                    | string       | "StorageV2" | no       |
| min_tls_version                 | string       | "TLS1_2"    | no       |
| https_traffic_only_enabled      | bool         | true        | no       |
| public_network_access_enabled   | bool         | false       | no       |
| blob_versioning_enabled         | bool         | true        | no       |
| blob_soft_delete_retention_days | number       | 7           | no       |
| containers                      | list(object) | []          | no       |
| network_rules                   | object       | null        | no       |
| tags                            | map(string)  | {}          | no       |

## Outputs

| Name                  | Description                      |
|-----------------------|----------------------------------|
| id                    | The ID of the storage account    |
| name                  | The name of the storage account  |
| primary_blob_endpoint | The primary blob endpoint        |
| container_names       | Names of created containers      |
