# App Registration Module

Creates an Azure AD application registration, service principal, and client secret.

## Usage

```hcl
module "app_registration" {
  source       = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/app-registration?ref=v1.2.0"
  display_name = "my-app"
  tags         = local.tags
}
```

## Inputs

| Name                     | Type                      | Default | Required |
|--------------------------|---------------------------|---------|----------|
| display_name             | string                    | n/a     | yes      |
| identifier_uris          | list(string)              | []      | no       |
| reply_urls               | list(string)              | []      | no       |
| required_resource_access | list(object)              | []      | no       |
| owners                   | list(string)              | []      | no       |
| tags                     | map(string)               | {}      | no       |

## Outputs

| Name                     | Description              |
|--------------------------|--------------------------|
| application_id           | The application ID       |
| object_id                | Object ID of the app     |
| service_principal_object_id | Object ID of the SP   |
| service_principal_application_id | Application ID of SP |
| client_secret            | Generated client secret  |
