terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.69.0"
    }
  }
}

provider "azurerm" {
  features{}
}

#create resource group
resource "azurerm_resource_group" "rg" {
    name     = "rgMyFirstTerraform"
    location = "westus2"
    tags      = {
      Environment = "Terraform Demo"
    }
}

#create app_service_plan
resource "azurerm_app_service_plan" "frontWebAppServicePlan" {
  name = "frontWebAppServicePlan"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Free"
    size = "F1"
  }
}

#create app_service
resource "azurerm_app_service" "frontwebapp" {
  name =  "${format("%s%s",azurerm_resource_group.rg.name,"DotNetWebApp")}"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.frontWebAppServicePlan.id
}