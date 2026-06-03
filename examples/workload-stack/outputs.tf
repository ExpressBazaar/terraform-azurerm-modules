output "aks_cluster_name" {
  value = module.aks.name
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "app_hostname" {
  value = module.app.default_hostname
}

output "sql_server_fqdn" {
  value = module.sql.server_fqdn
}
