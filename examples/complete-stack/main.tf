locals {
  location = "uksouth"
  tags = {
    environment = "prod"
    managed_by  = "terraform"
    project     = "complete-stack"
  }
}

module "rg" {
  source   = "../../modules/resource-group"
  name     = "rg-complete-prod"
  location = local.location
  tags     = local.tags
}

module "vnet" {
  source              = "../../modules/vnet"
  name                = "vnet-complete-prod"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.30.0.0/16"]
  tags                = local.tags
}

# ---- Web tier ----
module "subnet_web" {
  source              = "../../modules/subnet"
  name                = "snet-web"
  resource_group_name = module.rg.name
  vnet_name           = module.vnet.name
  address_prefixes    = ["10.30.1.0/24"]
  service_endpoints   = ["Microsoft.Storage"]
}

module "nsg_web" {
  source              = "../../modules/nsg"
  name                = "nsg-web"
  resource_group_name = module.rg.name
  location            = module.rg.location
  subnet_id           = module.subnet_web.id
  tags                = local.tags

  rules = [
    {
      name                   = "allow-https"
      priority               = 100
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      destination_port_range = "443"
    },
    {
      name                   = "allow-http"
      priority               = 110
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      destination_port_range = "80"
    }
  ]
}

# ---- App tier ----
module "subnet_app" {
  source              = "../../modules/subnet"
  name                = "snet-app"
  resource_group_name = module.rg.name
  vnet_name           = module.vnet.name
  address_prefixes    = ["10.30.2.0/24"]
}

module "nsg_app" {
  source              = "../../modules/nsg"
  name                = "nsg-app"
  resource_group_name = module.rg.name
  location            = module.rg.location
  subnet_id           = module.subnet_app.id
  tags                = local.tags

  rules = [
    {
      name                       = "allow-from-web"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      destination_port_range     = "8080"
      source_address_prefix      = "10.30.1.0/24"
      destination_address_prefix = "10.30.2.0/24"
    }
  ]
}

# ---- Egress routing via firewall appliance ----
module "route_table_app" {
  source              = "../../modules/route-table"
  name                = "rt-app"
  resource_group_name = module.rg.name
  location            = module.rg.location
  subnet_id           = module.subnet_app.id
  tags                = local.tags

  routes = [
    {
      name                   = "default-to-firewall"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.30.0.4"
    }
  ]
}
