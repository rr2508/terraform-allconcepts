resource "azurerm_public_ip" "pipcreate" {
  name                = var.pip_name
  resource_group_name = var.rgname
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = var.subnet_ids
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pipcreate.id
  }
}