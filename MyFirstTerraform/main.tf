terraform {
  required_providers {
    azurerm = {
      source = "./hashicorp"
      version = "2.9.0"
    }
  }
}

provider "azurerm" {
  features{}
}

#create resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg-MyFirstTerraform"
    location = "westus2"
    tags      = {
      Environment = "Terraform Demo"
    }
}