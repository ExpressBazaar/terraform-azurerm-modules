# Container App Environment Module

Creates an Azure Container App Environment — the secure boundary that hosts one or more Container Apps. Wire it to a Log Analytics workspace for logs, and optionally inject it into a subnet for VNet integration with an internal load balancer.

## Usage

```hcl
module "container_app_env" {
  source              = "git::https://github.com/ExpressBazaar/terraform-azurerm-modules.git//modules/container-app-environment?ref=v1.2.0"
  name                = "cae-app-prod-001"
  resource_group_name = module.rg.name
  location            = module.rg.location

  log_analytics_workspace_id     = module.log_analytics.id
  infrastructure_subnet_id       = module.subnet.id
  internal_load_balancer_enabled = true
  zone_redundancy_enabled        = true

  workload_profiles = [
    {
      name                  = "Consumption"
      workload_profile_type = "Consumption"
      minimum_count         = 0
      maximum_count         = 0
    }
  ]

  tags = local.tags
}
```

## Inputs

| Name                           | Type         | Default | Required |
|--------------------------------|--------------|---------|----------|
| name                           | string       | n/a     | yes      |
| resource_group_name            | string       | n/a     | yes      |
| location                       | string       | n/a     | yes      |
| log_analytics_workspace_id     | string       | null    | no       |
| infrastructure_subnet_id       | string       | null    | no       |
| internal_load_balancer_enabled | bool         | false   | no       |
| zone_redundancy_enabled        | bool         | false   | no       |
| workload_profiles              | list(object) | []      | no       |
| tags                           | map(string)  | {}      | no       |

## Outputs

| Name               | Description                                        |
|--------------------|----------------------------------------------------|
| id                 | The ID of the environment                          |
| name               | The name of the environment                        |
| default_domain     | The default, publicly resolvable domain            |
| static_ip_address  | The static IP address of the environment           |
| docker_bridge_cidr | The network address of the Docker bridge network   |
