terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.69.0"
    }
  }
}

provider "azurerm" {
  features {}
}

#create resource group
resource "azurerm_resource_group" "rgmyfirstdne" {
  name     = "rgmyfirstdne"
  location = "westus2"
  tags = {
    Environment = "Terraform Demo"
  }
}
#create sql server
resource "azurerm_sql_server" "sqlservermyfirstdne" {
  version                      = "12.0"
  administrator_login          = "sqlservermyfirstdne"
  administrator_login_password = "Welcome123"
  name                         = format("%s%s", azurerm_resource_group.rgmyfirstdne.name, "dotnetsqlserver")
  resource_group_name          = azurerm_resource_group.rgmyfirstdne.name
  location                     = azurerm_resource_group.rgmyfirstdne.location
}

#create sql elastic pool
resource "azurerm_sql_elasticpool" "sqlelasticpoolmyfirstdne" {
  server_name         = azurerm_sql_server.sqlservermyfirstdne.name
  location            = azurerm_resource_group.rgmyfirstdne.location
  resource_group_name = azurerm_resource_group.rgmyfirstdne.name
  dtu                 = "50"
  name                = format("%s%s", azurerm_resource_group.rgmyfirstdne.name, "dotnetsqlelasticpool")
  edition             = "Basic"
}

#create app_service_plan
resource "azurerm_app_service_plan" "frontWebAppServicePlan" {
  name                = format("%s%s", azurerm_resource_group.rgmyfirstdne.name, "DotNetWebServicePlan")
  location            = azurerm_resource_group.rgmyfirstdne.location
  resource_group_name = azurerm_resource_group.rgmyfirstdne.name
  sku {
    tier = "Free"
    size = "F1"
  }
}

#create app_service
resource "azurerm_app_service" "frontwebapp" {
  name                = format("%s%s", azurerm_resource_group.rgmyfirstdne.name, "DotNetWebApp")
  location            = azurerm_resource_group.rgmyfirstdne.location
  resource_group_name = azurerm_resource_group.rgmyfirstdne.name
  app_service_plan_id = azurerm_app_service_plan.frontWebAppServicePlan.id
}

#create virtual network
resource "azurerm_virtual_network" "webAppVirtualNetwork" {
  location            = azurerm_resource_group.rgmyfirstdne.location
  name                = format("%s%s", azurerm_resource_group.rgmyfirstdne.name, "DotNetVirtualNetwork")
  resource_group_name = azurerm_resource_group.rgmyfirstdne.name
  address_space       = ["10.10.20.0/21"]
}
