# Front Door Security Policy Module

Creates a security policy for an Azure CDN Front Door profile.

## Usage

```hcl
module "frontdoor_security_policy" {
  source                  = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/frontdoor-security-policy?ref=v1.2.0"
  name                    = "secpol-myapp-prod"
  cdn_frontdoor_profile_id = module.frontdoor.profile_id

  security_policies = [
    {
      name = "default-policy"
      type = "DefaultSecurityPolicy"
      settings = {
        enabled = true
      }
    }
  ]

  tags = local.tags
}
```

## Inputs

| Name                    | Type           | Default | Required |
|-------------------------|----------------|---------|----------|
| name                    | string         | n/a     | yes      |
| cdn_frontdoor_profile_id | string        | n/a     | yes      |
| security_policies       | list(object)   | []      | no       |
| tags                    | map(string)    | {}      | no       |

## Outputs

| Name | Description |
|------|-------------|
| id   | The ID of the security policy |
| name | The name of the security policy |
