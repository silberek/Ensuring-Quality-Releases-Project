# Azure subscription vars
subscription_id = "8b3d7883-6059-460e-9a47-6837e9097e9c"
client_id = "fa0bb5c6-96aa-4103-b2dc-a931b73c2dd7"
client_secret = "sUowMKSvpfWQ5lkXF9vUbLx3ooNVti~AR7"
tenant_id = "7004b1e4-3d39-4385-81f4-3d786fcaf887"

# Resource Group/Location
location = "westeurope"
resource_group = "tstate"
application_type = "kulfon"

# Network
virtual_network_name = "VNET-kulfon"
address_space = ["10.5.0.0/16"]
address_prefix_test = "10.5.1.0/24"

# VM
packer_image = "/subscriptions/8b3d7883-6059-460e-9a47-6837e9097e9c/resourceGroups/RG-myPackerImage/providers/Microsoft.Compute/images/myPackerImage"
admin_username = "kulfon"


# public key
public_key_path = "~/.ssh/id_rsa.pub"