# Front Door Module

Creates an Azure Front Door with routing rules, backend pools, and optional WAF policy linking.

## Usage

```hcl
module "frontdoor" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/frontdoor?ref=v1.2.0"
  name                = "fd-myapp-prod"
  resource_group_name = module.rg.name

  frontend_endpoints = [
    {
      name      = "fd-endpoint-prod"
      host_name = "myapp.example.com"
    }
  ]

  backend_pools = [
    {
      name = "pool-app"
      backend = {
        address     = "10.0.1.4"
        host_header = "myapp.example.com"
      }
      health_probe_settings = {
        name = "probe-default"
      }
      load_balancing_settings = {
        name = "lb-default"
      }
    }
  ]

  routing_rules = [
    {
      name               = "rule-default"
      accepted_protocols = ["Https"]
      patterns_to_match  = ["/*"]
      frontend_endpoints = ["fd-endpoint-prod"]
      forwarding_configuration = {
        backend_pool_name = "pool-app"
      }
    }
  ]

  waf_policy_link_id = module.waf.policy_id
  tags               = local.tags
}
```

## Inputs

| Name                     | Type           | Default | Required |
|--------------------------|----------------|---------|----------|
| name                     | string         | n/a     | yes      |
| resource_group_name      | string         | n/a     | yes      |
| routing_rules            | list(object)   | []      | no       |
| backend_pools            | list(object)   | []      | no       |
| frontend_endpoints       | list(object)   | []      | no       |
| waf_policy_link_id       | string         | null    | no       |
| tags                     | map(string)    | {}      | no       |

## Outputs

| Name     | Description              |
|----------|--------------------------|
| id       | The ID of the Front Door |
| name     | The name of the Front Door |
| host_name | The hostname of the Front Door |
