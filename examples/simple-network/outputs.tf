output "resource_group_name" {
  value = module.rg.name
}

output "vnet_id" {
  value = module.vnet.id
}

output "subnet_id" {
  value = module.subnet.id
}

output "nsg_id" {
  value = module.nsg.id
}
