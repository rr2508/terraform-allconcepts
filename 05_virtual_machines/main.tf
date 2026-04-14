resource "azurerm_resource_group" "rg" {
  name     = var.todo-rg
  location = local.resource_location
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.todo-vnet
  name                = each.value.name
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = each.value.address_space

}

resource "azurerm_subnet" "subnet" {
  for_each             = var.todo-subnet
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet["vn1"].name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_public_ip" "webip" {
  for_each            = var.pip-todo
  name                = each.value.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.resource_location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.nic-todo
  name                = each.value.name
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "ip_configuration" {
    for_each = var.ipconfig
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = azurerm_subnet.subnet["sn1"].id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = azurerm_public_ip.webip["pip1"].id
    }
  }
}


resource "azurerm_network_security_group" "nsg" {
  for_each            = var.todo-nsg
  name                = each.value.name
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "security_rule" {
    for_each = var.security_rule
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_appnsg" {
  subnet_id                 = azurerm_subnet.subnet["sn1"].id
  network_security_group_id = azurerm_network_security_group.nsg["nsg1"].id
}

resource "azurerm_linux_virtual_machine" "vm-todo" {
  for_each                        = var.vm-todo
  name                            = each.value.name
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = local.resource_location
  size                            = "Standard_D2s_v3"
  admin_username                  = "Adminuser1234"
  admin_password                  = "Adminuser@1234"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic["nic1"].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}



