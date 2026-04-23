resource "azurerm_resource_group" "aks-app-rg" {
  name     = "aks-app-rg"
  location = "France Central"
}

resource "azurerm_kubernetes_cluster" "app-aks" {
  name                = "app-aks"
  location            = azurerm_resource_group.aks-app-rg.location
  resource_group_name = azurerm_resource_group.aks-app-rg.name
  dns_prefix          = "appaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v6"
  }

  identity {
    type = "SystemAssigned"
  }

}

