# AKS Module

Creates an Azure Kubernetes Service cluster with a system-assigned identity, Azure CNI, an autoscaling default node pool across availability zones, optional Container Insights, and an optional `AcrPull` role assignment against a container registry.

## Usage

```hcl
module "aks" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/aks?ref=v1.2.0"
  name                = "aks-app-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
  dns_prefix          = "appprod"

  default_node_pool = {
    vnet_subnet_id = module.subnet_aks.id
    vm_size        = "Standard_D4s_v5"
    min_count      = 3
    max_count      = 10
  }

  log_analytics_workspace_id = module.log_analytics.id
  acr_id                     = module.acr.id

  tags = local.tags
}
```

## Inputs

| Name                       | Type        | Default          | Required |
|----------------------------|-------------|------------------|----------|
| name                       | string      | n/a              | yes      |
| resource_group_name        | string      | n/a              | yes      |
| location                   | string      | n/a              | yes      |
| dns_prefix                 | string      | n/a              | yes      |
| kubernetes_version         | string      | null             | no       |
| sku_tier                   | string      | "Standard"       | no       |
| default_node_pool          | object      | n/a (subnet req) | yes      |
| network_plugin             | string      | "azure"          | no       |
| network_policy             | string      | "calico"         | no       |
| service_cidr               | string      | "172.16.0.0/16"  | no       |
| dns_service_ip             | string      | "172.16.0.10"    | no       |
| log_analytics_workspace_id | string      | null             | no       |
| acr_id                     | string      | null             | no       |
| tags                       | map(string) | {}               | no       |

## Outputs

| Name                       | Description                          |
|----------------------------|--------------------------------------|
| id                         | The ID of the cluster                |
| name                       | The name of the cluster              |
| kubelet_identity_object_id | Kubelet managed identity object ID   |
| kube_config_raw            | Raw kubeconfig (sensitive)           |
| node_resource_group        | Auto-generated node resource group   |
