# Managed Identity Module

Creates an Azure user-assigned managed identity. Attach it to compute (AKS, Container Apps, VMs, App Service) and grant it roles (e.g. ACR `AcrPull`, Key Vault access) instead of using secrets or admin credentials.

## Usage

```hcl
module "identity" {
  source              = "git::https://github.com/ExpressBazaar/terraform-azurerm-modules.git//modules/managed-identity?ref=v1.2.0"
  name                = "id-app-prod-001"
  resource_group_name = module.rg.name
  location            = module.rg.location

  tags = local.tags
}

# Example: grant the identity pull access to an ACR
resource "azurerm_role_assignment" "acr_pull" {
  scope                = module.acr.id
  role_definition_name = "AcrPull"
  principal_id         = module.identity.principal_id
}
```

## Inputs

| Name                | Type        | Default | Required |
|---------------------|-------------|---------|----------|
| name                | string      | n/a     | yes      |
| resource_group_name | string      | n/a     | yes      |
| location            | string      | n/a     | yes      |
| tags                | map(string) | {}      | no       |

## Outputs

| Name         | Description                                        |
|--------------|----------------------------------------------------|
| id           | The ID of the managed identity                     |
| name         | The name of the managed identity                   |
| principal_id | The service principal (object) ID for role grants  |
| client_id    | The client ID used by applications to authenticate |
| tenant_id    | The tenant ID of the identity                      |
