# Linux VM Module

Creates a Linux virtual machine in Azure with a NIC, optional public IP, SSH key authentication, and configurable OS disk settings.

## Usage

```hcl
module "linux_vm" {
  source              = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/linux-vm?ref=v1.2.0"
  name                = "app-dev-vm"
  resource_group_name = module.rg.name
  location            = module.rg.location
  subnet_id           = module.subnet.id
  admin_username      = "azureuser"
  admin_ssh_public_key = file("~/.ssh/id_rsa.pub")

  tags = local.tags
}
```

## Inputs

| Name | Type | Default | Required |
|------|------|---------|----------|
| name | string | n/a | yes |
| resource_group_name | string | n/a | yes |
| location | string | n/a | yes |
| size | string | Standard_B2s | no |
| admin_username | string | n/a | yes |
| admin_ssh_public_key | string | n/a | yes |
| subnet_id | string | n/a | yes |
| os_disk_size_gb | number | 30 | no |
| os_disk_storage_account_type | string | Standard_LRS | no |
| source_image_reference | object | Ubuntu 22.04 | no |
| custom_data | string | null | no |
| disable_password_authentication | bool | true | no |
| public_ip_enabled | bool | true | no |
| tags | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| id | VM ID |
| name | VM name |
| private_ip_address | Primary private IP |
| public_ip_address | Public IP if created |
| network_interface_id | NIC ID |
