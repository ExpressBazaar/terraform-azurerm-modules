output "resource_group_name" {
  value = module.rg.name
}

output "vnet_id" {
  value = module.vnet.id
}

output "web_subnet_id" {
  value = module.subnet_web.id
}

output "app_subnet_id" {
  value = module.subnet_app.id
}
