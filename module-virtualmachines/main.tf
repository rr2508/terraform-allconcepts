module "create_rg" {
  source = "./01resource-group"
  rgname = var.rgname
  location = var.location
}

module "create_vnet" {
  depends_on = [ module.create_rg ]
  source = "./02vnet"
  rgname = var.rgname
  location = var.location
  vnet_name = var.vnet_name
  vnet_address_space = var.vnet_address_space
  subnet_name = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
}

module "create_nic"{
    depends_on = [ module.create_rg,module.create_vnet ]
    source = "./03nic"
    rgname = var.rgname
    pip_name = var.pip_name
    nic_name = var.nic_name
    location = var.location
    subnet_ids = module.create_vnet.subnet_ids
}

module "create_nsg" {
    depends_on = [ module.create_rg,module.create_vnet,module.create_nic ]
    source = "./04nsg"
    rgname = var.rgname
    nsg_name = var.nsg_name
    location = var.location
    security_rules = var.security_rules
}

module "associate_nsg" {
    depends_on = [ module.create_rg,module.create_vnet,module.create_nic,module.create_nsg ]
    source = "./05nsgAssociation"
    subnet_ids = module.create_vnet.subnet_ids
    nsg_id = module.create_nsg.nsg_id
}

module "create_vm" {
    depends_on = [ module.create_rg,module.create_vnet,module.create_nic,module.create_nsg ]
    source = "./06VirtualMachines"
    rgname = var.rgname
    vm_name = var.vm_name
    location = var.location
    nic_ids = module.create_nic.nic_ids
}