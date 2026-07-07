variable "name" {
  type        = string
  description = "Name of the Linux virtual machine."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group in which to create the VM."
}

variable "location" {
  type        = string
  description = "Azure region for the VM."
}

variable "size" {
  type        = string
  description = "Size of the virtual machine (for example Standard_B2s)."
  default     = "Standard_B2sStandard_D4s_v5"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM."
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key used to authenticate to the VM."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the NIC will be attached."
}

variable "os_disk_size_gb" {
  type        = number
  description = "Size of the OS disk in GB."
  default     = 30
}

variable "os_disk_storage_account_type" {
  type        = string
  description = "Storage account type for the OS disk."
  default     = "Standard_LRS"
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "Source image reference for the VM image."
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

variable "custom_data" {
  type        = string
  description = "Cloud-init or custom data script for the VM."
  default     = null
}

variable "disable_password_authentication" {
  type        = bool
  description = "Disable password authentication and require SSH keys."
  default     = true
}

variable "public_ip_enabled" {
  type        = bool
  description = "Create a public IP address for the VM."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the VM resources."
  default     = {}
}
