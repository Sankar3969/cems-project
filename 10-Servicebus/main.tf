
data "azurerm_resource_group" "cems-rs-group" {
  name = "cems-rs-group"
}
data "azurerm_client_config" "current" {}

resource "azurerm_servicebus_namespace" "cems-service-bus" {
  name                = "cems-servicebus-namespace"
  location            = data.azurerm_resource_group.cems-rs-group.location
  resource_group_name = data.azurerm_resource_group.cems-rs-group.name
  sku                 = "Basic"
  
  tags = {
    source = "terraform"
  }
}