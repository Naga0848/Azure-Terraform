### This repo contains all the details of the projects which we maintain here


# Projects — SSH key generation & usage

Short notes for this project about SSH key handling used by the VM Scale Set.

## What generates the key
- The Terraform resource `tls_private_key.vmss_key` (in `vmss.tf`) generates an RSA keypair when you run `terraform apply`.

## How the key is used
- The VMSS `admin_ssh_key` block uses `tls_private_key.vmss_key.public_key_openssh` as the public key for the `azureuser` account on VM instances.

## Important security note
- The private key produced by `tls_private_key` is stored in the Terraform state. Treat the state as sensitive (secure storage, backend with encryption, limited access).

## Alternatives (recommended for production)
- Generate the key outside Terraform and pass only the public key into Terraform via a variable to avoid storing the private key in state.

Example: generate key locally and provide public key as input
```bash
ssh-keygen -t rsa -b 4096 -f .ssh/key -N ""
```

Then set or pass `var.public_key` (string) and update `vmss.tf` to use `var.public_key` for `admin_ssh_key.public_key`.

Example HCL for external public key variable
```hcl
variable "public_key" { type = string }

admin_ssh_key {
  username   = "azureuser"
  public_key = var.public_key
}
```

## Quick Terraform commands
```bash
terraform init
terraform validate
terraform plan
```

If you want, I can patch the configuration to accept `var.public_key` and document how to pass it from CI or a secret manager.




=============================================================================================

Below is the architecture of the project which we are going to perform here

![alt text](Images/mini-project.png)

## Understanding the architecture

    * We will use a single resource group here as we are performing our preoject on KodeKloud hosted azure account.

        * We maintain the statefile in the same resource-group

    * VNET with a CIDR block range (10.0.00/16) ---->approximately 65357 IPs

    * Subnet A will be created in this VNET

    * A  VMSS will be created in this subnet

        VMSS stands for Virtual Machine Scale Sets. It is an Azure compute service that allows you to deploy, manage, and automatically scale a group of identical, load-balanced Virtual Machines (VMs). Instead of managing VMs individually, you manage them as a single collective set.

    * A loadbalancer (80/443) will be created in the VNET, so that the traffic coming from the outside will be routed to the VMSS depending on their health i.e., we use probes here to check the health of the VMs via http (if one of the VM is not healthy, the traffic will be routed to other VM)
    
        * Here VMSS are added as the backend pool to the loadbalancer to communicate.

    * As we dont give the loadbalancer IP to the outside world, we create a PublicIP here and attach it to the loadBalancer.

        * The traffic which comes to the PublicIP will be redirected to the loadbalancer and then it routes the traffic to the healthy VM.

    * We create a NSG and attach it o the subnet to allow the only traffic that is coming from the loadbalancer rather than allowing the complete traffic from outside. We design the rules in NSG according to our need.

        * An NSG (Network Security Group) in Microsoft Azure acts as a virtual firewall that filters inbound and outbound network traffic to and from Azure resources. It uses security rules based on IP addresses, ports, and protocols to allow or block connections, making it a foundational layer of cloud security.

    *  As we are restricting the traffic to the VMSS, we should create a NAT Gateway and attach it to the subnet, so that the VMs inside the VMSS will talk to the outside world and install the necessary patches or packages according the requirment.

    * We maintain somesrcipts related to the application in the userdata(html files), so that the application comes up once the VMs are created.


### Terraform documents used in the project

    * azurerm_subnet_network_security_group_association

        https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association

    * azurerm_virtual_network

        https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network     

    * azurerm_lb

        https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb   

    * azurerm_lb_backend_address_pool

        https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool

    * azurerm_lb_rule

        https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule

    * azurerm_lb_probe

        https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe

    * azurerm_lb_nat_rule

        https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_rule

    * azurerm_nat_gateway

        https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway

    * azurerm_nat_gateway_public_ip_association

        https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association

    * azurerm_windows_virtual_machine_scale_set

        https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine_scale_set

    * azurerm_monitor_autoscale_setting

        https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting




### understanding how to access the nginx web page which is used in our user-data.sh

    * go to azure portal

    * open resource-group

    * according to the vnet.tf file azurerm_public_ip is the loadbalancer which we created and the name of the loadbalancer is PublicIPForLB

    * under resource-group open the resource PublicIPForLB

    * cope the dns name as shown in the below image

![alt text](Images/dns.png)

    * use the url as dns/      ----> to see the nginx welcome page as below

            http://adriven-tarpon.eastus.cloudapp.azure.com/

![alt text](Images/nginx.png)