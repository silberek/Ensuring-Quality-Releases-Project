# Azure subscription vars
subscription_id = "8b3d7883-6059-460e-9a47-6837e9097e9c"
client_id = "50a31343-3b24-4ea6-93af-95227ebbb8f0"
client_secret = "WEh8Q~q-A9T3OTudytYAAIGOnActh-23MEvm8bk0"
tenant_id = "7004b1e4-3d39-4385-81f4-3d786fcaf887"

# Resource Group/Location
location = "westeurope"
resource_group = "tstate2"
application_type = "kulfon"

# Network
virtual_network_name = "VNET-kulfon"
address_space = ["10.5.0.0/16"]
address_prefix_test = "10.5.1.0/24"

# VM
packer_image = "/subscriptions/8b3d7883-6059-460e-9a47-6837e9097e9c/resourceGroups/RG-myPackerImage/providers/Microsoft.Compute/images/myPackerImage"
admin_username = "Kulfonik"
admin_password = "jakiesSobieHaslo123)"

# public key
public_key_path = "~/.ssh/id_rsa.pub"