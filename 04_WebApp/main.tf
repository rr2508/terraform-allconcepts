resource "azurerm_resource_group" "app-rg" {
  name     = "app-rg"
  location = local.resource_location
}

resource "azurerm_service_plan" "serviceplan" {
  for_each = var.webapp-environment.production.serviceplan
  name                = each.key
  resource_group_name = azurerm_resource_group.app-rg.name
  location            = local.resource_location
  sku_name            = each.value.sku_name
  os_type             = each.value.os_type
}

resource "azurerm_windows_web_app" "webapp" {
    for_each = var.webapp-environment.production.serviceapp
  name                = each.key
  resource_group_name = azurerm_resource_group.app-rg.name
  location            = local.resource_location
  service_plan_id     = azurerm_service_plan.serviceplan[each.value].id

  site_config {
    always_on = false
    application_stack {
        current_stack = "dotnet"
        dotnet_version = "v8.0"
    }
  }
}