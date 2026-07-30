variable "environment" {
    type = string
    default = "staging"
    description = "the env type or the env name"

}


# This variable is used when we want to use count(meta-argument) to create multiple resources of the same type. In this case, we are creating multiple storage accounts using the same resource block.
# variable "storage_account_name" {
    # type = list(string)
    # default = ["nagashankar0848", "nagashankar0849", "nagashankar0850"]
    # description = "the storage account name"
# }

variable "storage_account_name" {
  type = set(string)
  default = [ "nagashankar0848", "nagashankar0849", "nagashankar0850" ]
  description = "the storage account name"
}