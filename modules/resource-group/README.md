# Resource Group Module

Creates an Azure Resource Group.

## Usage

```hcl
module "rg" {
  source   = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/resource-group?ref=v1.0.0"
  name     = "rg-app-dev"
  location = "uksouth"
  tags     = { environment = "dev" }
}
```

## Inputs

| Name     | Type        | Default | Required |
|----------|-------------|---------|----------|
| name     | string      | n/a     | yes      |
| location | string      | n/a     | yes      |
| tags     | map(string) | {}      | no       |

## Outputs

| Name     | Description                         |
|----------|-------------------------------------|
| id       | The ID of the resource group        |
| name     | The name of the resource group      |
| location | The location of the resource group  |
