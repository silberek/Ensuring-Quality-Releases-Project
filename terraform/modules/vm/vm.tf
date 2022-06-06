resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-NIC"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                            = "${var.application_type}-VM"
  location                        = var.location
  resource_group_name             = var.resource_group
  size                            = "Standard_B2s"
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  #source_image_id                 = var.packer_image
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.test.id]

  admin_ssh_key {
  username   = var.admin_username
  #Local ssh deployment
  #public_key = file("~/.ssh/id_rsa.pub")?
  #Azure ssh deployment Ubuntu
  public_key = file("/home/vsts/work/_temp/id_rsa.pub")
  #Azure ssh deployment Windows
  #public_key = file("D:/a/_temp/id_rsa")
  }

  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
