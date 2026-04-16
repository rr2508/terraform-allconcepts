resource "azurerm_linux_virtual_machine" "vmcreate" {
  name                = var.vm_name
  resource_group_name = var.rgname
  location            = var.location
  size                = "Standard_D2s_v3"
  admin_username      = "Adminuser1234"
  admin_password = "Adminuser@1234"
  disable_password_authentication = false
  network_interface_ids = [
    var.nic_ids
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