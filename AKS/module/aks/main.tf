# Datasource to get Latest Azure AKS latest Version
# Check if there is a var with the version name , if not , use the latest version, if there is a var, use that version
# make sure the version specified in var is valid



# Declare the existing Resource Group using a Data Source
data "azurerm_resource_group" "existing_rg" {
  name = "kml_rg_main-17b80cc4f84444ef"
}


data "azurerm_kubernetes_service_versions" "current" {
  location = var.location
  include_preview = false  
}


  
resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                  = "techtutorialwithpiyush-aks-cluster"
  location              = data.azurerm_resource_group.existing_rg.location
  resource_group_name   = data.azurerm_resource_group.existing_rg.name
  dns_prefix            = "${var.existing_rg_name}-cluster"           
  kubernetes_version    =  data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${var.existing_rg_name}-nrg"
  
  default_node_pool {
    name       = "defaultpool"
    vm_size    = "Standard_D2s_v3"
    zones   = [1, 2, 3]
    auto_scaling_enabled = true
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type"    = "system"
      "environment"      = "prod"
      "nodepoolos"       = "linux"
     } 
   tags = {
      "nodepool-type"    = "system"
      "environment"      = "prod"
      "nodepoolos"       = "linux"
   } 
  }


# to do: generate the ssh keys using tls_private_key
# upload the key to key vault

  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
        key_data = trimspace(file(var.ssh_public_key))
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
      network_plugin = "azure"
      load_balancer_sku = "standard"
  }
}

output "config" {
  description = "Kubernetes config file content for the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks-cluster.kube_config_raw
}
