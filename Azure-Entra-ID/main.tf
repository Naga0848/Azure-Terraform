
#  Declare the existing Resource Group using a Data Source
# data "azurerm_resource_group" "existing_rg" {
  # name = "kml_rg_main-942eb72e30fe455a"
# }



# This is the extra storage account resource block which is created using the for_each meta-argument. The for_each meta-argument is used to create multiple resources of the same type using a single resource block. In this case, we are creating multiple storage accounts using the same resource block.
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


# Here we are using the azure data source (azuread) to get the existing domains in the current subscription

data "azuread_domains" "aad_domains" {}

output "domain_names" {
  value = data.azuread_domains.aad_domains.domains.*.domain_name
}


# Now we are using locals here, so that we can use in multiple places in the code. We are using the local variable to store the domain names which we got from the azuread_domains data source. We are also using the local variable to store the domain names in a list format, so that we can use it in multiple places in the code.
locals {
  domain_name = data.azuread_domains.aad_domains.domains.*.domain_name
  users = csvdecode(file("users.csv"))    # this is to decode the csv file and store it in a local variable. We can use this local variable in the resource block to create multiple users using the for_each meta-argument.
}


# Outputs
  output "domain" {
  value = local.domain_name
  }
 # this output is to print the usernames of the users which we are creating using the for_each meta-argument. We are using the local variable to get the first name and last name of the users and then we are concatenating them to get the full name of the user.
output "username" {
    value = [for user in local.users : "${user.first_name} ${user.last_name}"]
  }