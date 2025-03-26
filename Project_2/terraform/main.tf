variable "SUBSCRIPTION_ID" {
  description = "Azure Subscription ID"
  type        = string
}

variable "CLIENT_ID" {
  description = "Azure Client ID"
  type        = string
}

variable "CLIENT_SECRET" {
  description = "Azure Client Secret"
  type        = string
  sensitive   = true
}

variable "TENANT_ID" {
  description = "Azure Tenant ID"
  type        = string
}

provider "azurerm" {
  features {}
  subscription_id = var.SUBSCRIPTION_ID
  client_id       = var.CLIENT_ID
  client_secret   = var.CLIENT_SECRET
  tenant_id       = var.TENANT_ID
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "RG1"
  location = "East US"
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Output
output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

