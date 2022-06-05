# Resource Group/Location
variable "location" {}
variable "resource_group" {}
variable "application_type" {}
variable "name" {}

# Network
variable "public_ip_address_id" {}
variable "subnet_id" {}

# VM
variable "admin_username" {}
variable "admin_password" {}
#variable "packer_image" {}
variable "public_key_path" {}
