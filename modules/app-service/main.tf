resource "azurerm_service_plan" "this" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
  worker_count        = var.worker_count
  tags                = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  service_plan_id           = azurerm_service_plan.this.id
  https_only                = var.https_only
  virtual_network_subnet_id = var.vnet_integration_subnet_id
  app_settings              = var.app_settings
  tags                      = var.tags

  identity {
    type = "SystemAssigned"
  }

  site_config {
    minimum_tls_version = var.minimum_tls_version

    application_stack {
      docker_image_name   = var.application_stack.docker_image_name
      docker_registry_url = var.application_stack.docker_registry_url
      dotnet_version      = var.application_stack.dotnet_version
      node_version        = var.application_stack.node_version
      python_version      = var.application_stack.python_version
    }
  }
}
