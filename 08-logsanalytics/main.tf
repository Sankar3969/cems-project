
data "azurerm_resource_group" "cems-rs-group" {
  name = "cems-rs-group"
}
data "azurerm_client_config" "current" {}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "cems-logs-workspace"
  location            = data.azurerm_resource_group.cems-rs-group.location
  resource_group_name = data.azurerm_resource_group.cems-rs-group.name
  sku                 = "PerGB2018"  # Other options: Free, Standalone, CapacityReservation, etc.
  retention_in_days   = 30

  tags = {
    environment = "dev"
  }
}