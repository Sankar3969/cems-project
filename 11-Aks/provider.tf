terraform {
  required_version = ">= 1.8.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.105.0" # or latest stable version
    }
  }
}

provider "azurerm" {
  features {}
}
