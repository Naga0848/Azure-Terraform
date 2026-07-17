
# Already this resource group is created in the Azure portal. We are using a data source to reference it in our Terraform configuration.
data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}

# As we are keeping the subnet related code blocks inside the virtual network resource block, we don't need to create a separate resource block for the subnet. The subnet will be created as part of the virtual network resource block. And we need not to mention the virtual network name and the resource-group names in the subnet code block
resource "azurerm_virtual_network" "example" {
  name                = var.azurerm_virtual_network_name
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  address_space       = ["10.0.0.0/16"]
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]


  subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]

  }


  # subnet {
    # name             = "subnet2"
    # address_prefixes = ["10.0.2.0/24"]
  # }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_group" "example" {
  name                = var.azurerm_network_security_group_name
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  #ssh security rule
  security_rule {
    name                       = "allow-ssh"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
