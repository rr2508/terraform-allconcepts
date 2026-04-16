resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.rgname
}

resource "azurerm_subnet" "internal" {
  depends_on = [ azurerm_virtual_network.main ]
  name                 = var.subnet_name
  resource_group_name  = var.rgname
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet_address_prefixes
}