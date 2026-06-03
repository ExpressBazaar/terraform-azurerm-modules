locals {
  location = "uksouth"
  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

module "rg" {
  source   = "../../modules/resource-group"
  name     = "rg-simple-dev"
  location = local.location
  tags     = local.tags
}

module "vnet" {
  source              = "../../modules/vnet"
  name                = "vnet-simple-dev"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.20.0.0/16"]
  tags                = local.tags
}

module "subnet" {
  source              = "../../modules/subnet"
  name                = "snet-app"
  resource_group_name = module.rg.name
  vnet_name           = module.vnet.name
  address_prefixes    = ["10.20.1.0/24"]
}

module "nsg" {
  source              = "../../modules/nsg"
  name                = "nsg-app"
  resource_group_name = module.rg.name
  location            = module.rg.location
  subnet_id           = module.subnet.id

  rules = [
    {
      name                   = "allow-https-inbound"
      priority               = 100
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      destination_port_range = "443"
    }
  ]

  tags = local.tags
}
