
#  Declare the existing Resource Group using a Data Source
data "azurerm_resource_group" "existing_rg" {
  name = "kml_rg_main-ab1e84bd82fd4264"
}


resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name[count.index]
  count                    = length(var.storage_account_name)
  resource_group_name      = data.azurerm_resource_group.existing_rg.name
  location                 = data.azurerm_resource_group.existing_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}