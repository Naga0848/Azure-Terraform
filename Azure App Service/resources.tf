
# this is the resource block for ASP
resource "azurerm_service_plan" "asp" {
  name                = "example"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  location            = data.azurerm_resource_group.existing_rg.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

# this is the resource block for Linux Web App
resource "azurerm_linux_web_app" "example" {
  name                = "webapp"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  location            = data.azurerm_resource_group.existing_rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {}
}

# This resource is for deployment slot1
resource "azurerm_linux_web_app_slot" "example" {
  name           = "example-slot1"
  app_service_id = azurerm_linux_web_app.webapp.id

  site_config {}
}


# This resource is for deployment slot2
resource "azurerm_linux_web_app_slot" "example" {
  name           = "example-slot2"
  app_service_id = azurerm_linux_web_app.webapp.id

  site_config {}
}



