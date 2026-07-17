resource "random_pet" "lb_hostname" {
}


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

# This code block is used to associate the network security group with the subnet. The subnet_id is the id of the subnet that we want to associate with the network security group. The network_security_group_id is the id of the network security group that we want to associate with the subnet.
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = subnet1.id
  network_security_group_id = azurerm_network_security_group.example.id
}



# PublicIP needs to be created before the Loadbalaction is created.
  
resource "azurerm_public_ip" "example" {
  name                = "PublicIPForLB"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  domain_name_label   = "${data.azurerm_resource_group.existing_rg.name}-${random_pet.lb_hostname.id}"
}

# This code block is for creating a load balancer. The frontend_ip_configuration block is used to configure the frontend IP address of the load balancer. The public_ip_address_id is the id of the public IP address that we want to associate with the load balancer. The name is the name of the frontend IP configuration.
resource "azurerm_lb" "example" {
  name                = "TestLoadBalancer"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  sku                 = "Standard"

# this block is for the publicIP which we are using to access the application rather than the Loadbalanacer.
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

# This resource block connects the load balancer to the backend pool. The loadbalancer_id is the id of the load balancer that we want to associate with the backend pool. The name is the name of the backend pool.
resource "azurerm_lb_backend_address_pool" "example" {
  loadbalancer_id = azurerm_lb.example.id
  name            = "BackEndAddressPool"
}

# this code block is for associating the backendpool with the loadbalanceremoved 
  
resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = azurerm_lb.example.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.example.id]
}