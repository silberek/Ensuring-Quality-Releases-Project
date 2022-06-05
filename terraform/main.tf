provider "azurerm" {
  skip_provider_registration = true
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.50.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "tstate20985"
    container_name       = "tstate2"
    key                  = "terraform.tfstate"
    access_key           = "DXTPQKM5Fj0C04Mq8VIefZXlIxJ3feT5nPTAIug+xMiNs0+sHs87nhLJWbilh4nik/GDpRml46tm+ASt+e/IEw=="
  }
}
module "resource_group" {
  source               = "./modules/resource_group"
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
}
module "network" {
  source               = "./modules/network"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  virtual_network_name = "${var.virtual_network_name}"
  application_type     = "${var.application_type}"
  resource_type        = "NET"
  resource_group       = "${var.resource_group}"
  address_prefix_test  = "${var.address_prefix_test}"
}

module "nsg-test" {
  source           = "./modules/networksecuritygroup"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "NSG"
  resource_group   = "${var.resource_group}"
  subnet_id        = "${module.network.subnet_id}"
  address_prefix_test = "${var.address_prefix_test}"
}
module "appservice" {
  source           = "./modules/appservice"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "AppService"
  resource_group   = "${var.resource_group}"
}
module "publicip" {
  source           = "./modules/publicip"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "PublicIp"
  resource_group   = "${var.resource_group}"
}
module "vm" {
  source               = "./modules/vm"
  name                 = "vm-for-test"
  location             = "${var.location}"
  #packer_image         = "${var.packer_image}"
  public_key_path      = "${var.public_key_path}"
  application_type     = "${var.application_type}"
  resource_group       = "${var.resource_group}"
  public_ip_address_id = "${module.publicip.public_ip_address_id}"
  subnet_id            = "${module.network.subnet_id}"
  admin_username       = "${var.admin_username}"
  admin_password       = "${var.admin_password}"
}
