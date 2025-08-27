
data "azurerm_resource_group" "cems-rs-group" {
  name = "cems-rs-group"
}
# use existing vnet for Aks  which is created for APPgateway for integrate ingress controller
data "azurerm_virtual_network" "cems-app-vnet" {
  name = "cems-app-vnet"
  resource_group_name = data.azurerm_resource_group.cems-rs-group.name
}

resource "azurerm_subnet" "cems-aks-subnet" {
  name                 = "cems-aks-subnet"
  resource_group_name  = data.azurerm_resource_group.cems-rs-group.name
  virtual_network_name = data.azurerm_virtual_network.cems-app-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_kubernetes_cluster" "cems_aks_cluster" {
  name                = "cemsakscluster"
  location            = data.azurerm_resource_group.cems-rs-group.location
  resource_group_name = data.azurerm_resource_group.cems-rs-group.name
  dns_prefix          = "cemsakscluster"

  default_node_pool {
    name       = "agentpool"
    node_count = 1
    vm_size    = "Standard_D2ls_v5"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 2
    vnet_subnet_id = azurerm_subnet.cems-aks-subnet.id
  }
  network_profile {
   network_plugin     = "azure"
   network_policy     = "azure"
   load_balancer_sku  = "standard"

   service_cidr       = "10.1.0.0/16"
   dns_service_ip     = "10.1.0.10"
   docker_bridge_cidr = "10.2.0.1/16"
 }
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}

