variable "environment" {
    type = string
    default = "staging"
    description = "the env type or the env name"

}

variable "resource_group_name" {
    type = string
    default = "kml_rg_main-68517b9db7f34216"
    description = "the resource group name"
  
}

variable "azurerm_virtual_network_name" {
    type = string
    default = "example-network"
    description = "the virtual network name"
  
}

variable "azurerm_network_security_group_name" {
    type = string
    default = "example-security-group"
    description = "the network security group name"
  
}

# This variable is used when we want to use count(meta-argument) to create multiple resources of the same type. In this case, we are creating multiple storage accounts using the same resource block.
# variable "storage_account_name" {
    # type = list(string)
    # default = ["nagashankar0848", "nagashankar0849", "nagashankar0850"]
    # description = "the storage account name"
# }

# variable "storage_account_name" {
#   type = set(string)
#   default = [ "nagashankar0848", "nagashankar0849", "nagashankar0850" ]
#   description = "the storage account name"
# }