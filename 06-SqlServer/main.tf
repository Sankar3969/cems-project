
data "azurerm_resource_group" "cems-rs-group" {
  name = "cems-rs-group"
}
data "azurerm_client_config" "current" {}

resource "azurerm_mssql_server" "cemssqlserver" {
  name                         = "cemssqlserver"
  resource_group_name          = data.azurerm_resource_group.cems-rs-group.name
  location                     = data.azurerm_resource_group.cems-rs-group.location
  version                      = "12.0"
  administrator_login          = "Admin1"
  administrator_login_password = "Test@1234"
  minimum_tls_version          = "1.2"

 /*azuread_administrator {
    login_username = "sankararao.juvva_outlook.com#EXT#@sankararaojuvvaoutlook.onmicrosoft.com"
    object_id      = "c820a7b8-3076-4dda-9468-86f93989a20f"
  }*/ 

  tags = {
    environment = "dev"
  }
}

/*  to future reference

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "existing" {
  name = "cems-rs-group"
}

resource "azurerm_virtual_network" "example_vnet" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
}

resource "azurerm_subnet" "example_subnet" {
  name                 = "example-subnet"
  resource_group_name  = data.azurerm_resource_group.existing.name
  virtual_network_name = azurerm_virtual_network.example_vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  service_endpoints = ["Microsoft.Sql"]
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = "myuniquesqlserver123"
  location                     = data.azurerm_resource_group.existing.location
  resource_group_name          = data.azurerm_resource_group.existing.name
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = "YourStrongP@ssw0rd!"
  public_network_access_enabled = false

  azuread_administrator {
    login_username = "sankararao.juvva_outlook.com#EXT#@sankararaojuvvaoutlook.onmicrosoft.com"
    object_id      = "c820a7b8-3076-4dda-9468-86f93989a20f"
  }
}

resource "azurerm_private_endpoint" "sql_private_endpoint" {
  name                = "sql-private-endpoint"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  subnet_id           = azurerm_subnet.example_subnet.id

  private_service_connection {
    name                           = "sql-privatesc"
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
}
*/