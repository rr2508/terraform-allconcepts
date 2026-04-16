rgname = "app-rg"
location = "Canada Central"
vnet_name = "app-vnet"
vnet_address_space = ["10.0.0.0/16"]
subnet_name = "app-subnet"
subnet_address_prefixes = ["10.0.2.0/24"]
pip_name = "app-pip"
nic_name = "app-nic"
nsg_name = "app-nsg"
security_rules = {
    nsg1 = {
        name = "SSH-allow"
        port = "22"
        priority = 100
    },
    nsg2 = {
        name = "HTTP-allow"
        port = "80"
        priority = 200
    }
}

vm_name = "app-vm"