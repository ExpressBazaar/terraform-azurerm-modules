data "azurerm_client_config" "current" {}

locals {
  location = "uksouth"
  tags = {
    environment = "prod"
    managed_by  = "terraform"
    layer       = "platform"
  }
}

# ---- Phase 1: network foundation ----
module "rg" {
  source   = "../../modules/resource-group"
  name     = "rg-platform-prod"
  location = local.location
  tags     = local.tags
}

module "vnet" {
  source              = "../../modules/vnet"
  name                = "vnet-platform-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.40.0.0/16"]
  tags                = local.tags
}

module "subnet_pe" {
  source              = "../../modules/subnet"
  name                = "snet-private-endpoints"
  resource_group_name = module.rg.name
  vnet_name           = module.vnet.name
  address_prefixes    = ["10.40.1.0/24"]
  service_endpoints   = ["Microsoft.KeyVault", "Microsoft.Storage"]
}

# ---- Phase 2: platform services ----
module "log_analytics" {
  source              = "../../modules/log-analytics"
  name                = "log-platform-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
  retention_in_days   = 90
  tags                = local.tags
}

module "key_vault" {
  source              = "../../modules/key-vault"
  name                = "kv-platform-prod01"
  resource_group_name = module.rg.name
  location            = module.rg.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

  network_acls = {
    default_action             = "Deny"
    virtual_network_subnet_ids = [module.subnet_pe.id]
  }

  tags = local.tags
}

module "storage" {
  source              = "../../modules/storage-account"
  name                = "stplatformprod001"
  resource_group_name = module.rg.name
  location            = module.rg.location

  containers = [
    { name = "app-data" },
    { name = "diagnostics" }
  ]

  network_rules = {
    default_action             = "Deny"
    virtual_network_subnet_ids = [module.subnet_pe.id]
  }

  tags = local.tags
}

module "private_dns_kv" {
  source              = "../../modules/private-dns-zone"
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = module.rg.name

  virtual_network_links = [
    {
      name               = "link-to-platform-vnet"
      virtual_network_id = module.vnet.id
    }
  ]

  tags = local.tags
}
