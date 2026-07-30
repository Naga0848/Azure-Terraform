
# #  creating a resource group
# resource "azurerm_resource_group" "rg" {
  # name     = "nagashankar-rg"
  # location = "West Europe"
# }

# This is the extra storage account resource block that is commented out. It is not being used in the current configuration, but it can be uncommented and modified as needed to create additional storage accounts.
# resource "azurerm_storage_account" "example" {
  # #name                    = var.storage_account_name[count.index]
  # #count = length(var.storage_account_name)
  # for_each                 = var.storage_account_name
  # name                     = each.value
  # resource_group_name      = data.azurerm_resource_group.existing_rg.name
  # location                 = data.azurerm_resource_group.existing_rg.location
  # account_tier             = "Standard"
  # account_replication_type = "GRS"

  # tags = {
    # environment = "staging"
  # }
# }