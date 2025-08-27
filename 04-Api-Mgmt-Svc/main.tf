resource "azurerm_resource_group" "cems-rs-group"{
name = "cems-rs-group"
location= "UK South"
}

resource "azurerm_api_management" "cems-apim" {
  name                = "cems-apim-service"
  location            = azurerm_resource_group.cems-rs-group.location
  resource_group_name = azurerm_resource_group.cems-rs-group.name
  publisher_name      = "cems"
  publisher_email     = "sankar.js@outlook.com"
  sku_name            = "Basic_1"  # Other options: Basic_1, Standard_1, Premium_1

  tags = {
    environment = "dev"
  }
}
