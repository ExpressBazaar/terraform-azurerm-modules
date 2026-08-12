# WAF Module

Creates an Azure Web Application Firewall (WAF) policy for Front Door or Application Gateway.

## Usage

```hcl
module "waf" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/waf?ref=v1.2.0"
  name                = "waf-myapp-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
  mode                = "Prevention"

  custom_rules = [
    {
      name     = "block-known-bad-ips"
      priority = 1
      action   = "Block"
      match_conditions = [
        {
          match_variables = [
            {
              variable_name = "RemoteAddr"
              operator      = "IPMatch"
              match_values  = ["10.0.0.0/8"]
            }
          ]
        }
      ]
    }
  ]

  tags = local.tags
}
```

## Inputs

| Name           | Type        | Default | Required |
|----------------|-------------|---------|----------|
| name           | string      | n/a     | yes      |
| resource_group_name | string | n/a     | yes      |
| location       | string      | n/a     | yes      |
| mode           | string      | "Prevention" | no |
| managed_rules  | object      | {}      | no       |
| custom_rules   | list(object) | []     | no       |
| tags           | map(string) | {}      | no       |

## Outputs

| Name     | Description              |
|----------|--------------------------|
| id       | The ID of the WAF policy |
| name     | The name of the WAF policy |
| policy_id | The ID of the WAF policy |
