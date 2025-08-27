
data "azurerm_resource_group" "cems-rs-group" {
  name = "cems-rs-group"
}
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "cems-kv" {
  name                        = "cems-key-vault"
  location                    = data.azurerm_resource_group.cems-rs-group.location
  resource_group_name         = data.azurerm_resource_group.cems-rs-group.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  enable_rbac_authorization   = true
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7
  public_network_access_enabled = true  # Disable public access

  tags = {
    environment = "dev"
  }
   /*access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
  
    virtual_network_subnet_ids = [
      azurerm_subnet.example_subnet.id         # Allow access from this subnet
    ]
  }

  */
}


  # if public_network_access_enabled = flase
/* 
resource "azurerm_virtual_network" "example_vnet" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "example_subnet" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.example_vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  service_endpoints = ["Microsoft.KeyVault"]
}
resource "azurerm_key_vault_secret" "example" {
  name         = "my-secret"
  value        = "super-secret-value"
  key_vault_id = azurerm_key_vault.kv.id
}
*/ 