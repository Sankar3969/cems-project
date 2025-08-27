
data "azurerm_resource_group" "cems-rs-group" {
  name = "cems-rs-group"
}
data "azurerm_client_config" "current" {}

resource "azurerm_redis_cache" "cems-cache-redis" {
  name                 = "cems-cache-redis"
  location             = data.azurerm_resource_group.cems-rs-group.location
  resource_group_name  = data.azurerm_resource_group.cems-rs-group.name
  capacity             = 2
  family               = "C"
  sku_name             = "Standard"
  #non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"
  redis_configuration {
  }
}