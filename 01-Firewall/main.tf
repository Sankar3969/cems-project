resource "azurerm_resource_group" "cems-rs-group"{
name = "cems-rs-group"
location= "UK South"
}

resource "azurerm_public_ip" "firewall_pip" {
  count               = 2
  name                = count.index == 0 ? "cems-fw-subnet-pip" : "cems-fw-mgmtNIC-pip"
  location            = azurerm_resource_group.cems-rs-group.location
  resource_group_name = azurerm_resource_group.cems-rs-group.name
  allocation_method   = "Static"
  sku                 = "Standard" 
  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "cems-fw-vnet" {
  name                = "cems-fw-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.cems-rs-group.location
  resource_group_name = azurerm_resource_group.cems-rs-group.name
}
resource "azurerm_subnet" "AzureFirewallSubnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.cems-rs-group.name
  virtual_network_name = azurerm_virtual_network.cems-fw-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_firewall" "cems-firewall" {
  name                = "cems-firewall"
  location            = azurerm_resource_group.cems-rs-group.location
  resource_group_name = azurerm_resource_group.cems-rs-group.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip[0].id
  }
}
