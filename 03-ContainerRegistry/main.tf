resource "azurerm_resource_group" "cems-rs-group"{
name = "cems-rs-group"
location= "UK South"
}

resource "azurerm_container_registry" "cems-acr" {
  name                = "cemsacr"
  resource_group_name = azurerm_resource_group.cems-rs-group.name
  location            = azurerm_resource_group.cems-rs-group.location
  sku                 = "Standard"
  admin_enabled       = false
}