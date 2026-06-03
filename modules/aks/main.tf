resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.sku_tier
  tags                = var.tags

  default_node_pool {
    name                 = var.default_node_pool.name
    vm_size              = var.default_node_pool.vm_size
    node_count           = var.default_node_pool.node_count
    auto_scaling_enabled = var.default_node_pool.auto_scaling_enabled
    min_count            = var.default_node_pool.auto_scaling_enabled ? var.default_node_pool.min_count : null
    max_count            = var.default_node_pool.auto_scaling_enabled ? var.default_node_pool.max_count : null
    vnet_subnet_id       = var.default_node_pool.vnet_subnet_id
    zones                = var.default_node_pool.zones
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = var.network_plugin
    network_policy = var.network_policy
    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }

  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id == null ? [] : [1]
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  count                            = var.acr_id == null ? 0 : 1
  scope                            = var.acr_id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  skip_service_principal_aad_check = true
}
