### This repo contains all the details of the projects which we maintain here


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