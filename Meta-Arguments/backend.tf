terraform {
  backend "azurerm" {
    resource_group_name  = "kml_rg_main-0a87132c14354ac5"  # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "nagastatefile"                      # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "dev.terraform.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
  }
  # We have created the storage-account using the backend.sh shell script and using it here. When we run the terraform init command dev.terraform.tfstate will be created in the blob containers
  