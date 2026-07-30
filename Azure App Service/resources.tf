
# this is the resource block for ASP
resource "azurerm_service_plan" "asp" {
  name                = "kml-app-service-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "P0v3"
}

# this is the resource block for Linux Web App
resource "azurerm_linux_web_app" "app" {
  name                = "kml-naga-app-service"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {}
}

# This resource is for deployment slot1
resource "azurerm_linux_web_app_slot" "slot1" {
  name           = "kml-naga-app-service-slot1"
  app_service_id = azurerm_linux_web_app.app.id

  site_config {}
}


#  This resource is for deployment slot2
resource "azurerm_linux_web_app_slot" "example" {
  name           = "example-slot2"
  app_service_id = azurerm_linux_web_app.app.id

  site_config {}
}



