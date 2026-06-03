data "azurerm_client_config" "current" {}

locals {
  location = "uksouth"
  tags = {
    environment = "prod"
    managed_by  = "terraform"
    layer       = "workload"
  }
}

# ---- Phase 1: network ----
module "rg" {
  source   = "../../modules/resource-group"
  name     = "rg-workload-prod"
  location = local.location
  tags     = local.tags
}

module "vnet" {
  source              = "../../modules/vnet"
  name                = "vnet-workload-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.50.0.0/16"]
  tags                = local.tags
}

module "subnet_aks" {
  source              = "../../modules/subnet"
  name                = "snet-aks"
  resource_group_name = module.rg.name
  vnet_name           = module.vnet.name
  address_prefixes    = ["10.50.1.0/24"]
}

module "subnet_app" {
  source              = "../../modules/subnet"
  name                = "snet-app"
  resource_group_name = module.rg.name
  vnet_name           = module.vnet.name
  address_prefixes    = ["10.50.2.0/24"]

  delegations = [
    {
      name         = "webapp-delegation"
      service_name = "Microsoft.Web/serverFarms"
      actions      = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  ]
}

# ---- Phase 2: observability ----
module "log_analytics" {
  source              = "../../modules/log-analytics"
  name                = "log-workload-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
  retention_in_days   = 90

  solutions = [
    {
      solution_name = "ContainerInsights"
      publisher     = "Microsoft"
      product       = "OMSGallery/ContainerInsights"
    }
  ]

  tags = local.tags
}

# ---- Phase 3: workload services ----
module "acr" {
  source                        = "../../modules/container-registry"
  name                          = "acrworkloadprod01"
  resource_group_name           = module.rg.name
  location                      = module.rg.location
  sku                           = "Premium"
  public_network_access_enabled = true
  tags                          = local.tags
}

module "aks" {
  source              = "../../modules/aks"
  name                = "aks-workload-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
  dns_prefix          = "workloadprod"

  default_node_pool = {
    vnet_subnet_id = module.subnet_aks.id
    vm_size        = "Standard_D4s_v5"
    min_count      = 3
    max_count      = 8
  }

  log_analytics_workspace_id = module.log_analytics.id
  acr_id                     = module.acr.id

  tags = local.tags
}

module "app" {
  source              = "../../modules/app-service"
  name                = "app-workload-prod01"
  resource_group_name = module.rg.name
  location            = module.rg.location
  service_plan_name   = "asp-workload-prod"
  sku_name            = "P1v3"

  application_stack = {
    node_version = "20-lts"
  }

  vnet_integration_subnet_id = module.subnet_app.id
  tags                       = local.tags
}

module "sql" {
  source              = "../../modules/sql"
  server_name         = "sql-workload-prod01"
  resource_group_name = module.rg.name
  location            = module.rg.location

  azuread_administrator = {
    login_username = "sql-admins"
    object_id      = var.sql_admin_group_object_id
  }

  databases = [
    { name = "appdb", sku_name = "S1", max_size_gb = 50 }
  ]

  tags = local.tags
}
