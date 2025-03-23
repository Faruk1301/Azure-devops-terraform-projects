# Declare variables for Azure credentials
variable "SUBSCRIPTION_ID" {
  description = "The subscription ID"
}

variable "CLIENT_ID" {
  description = "The client ID"
}

variable "CLIENT_SECRET" {
  description = "The client secret"
  sensitive   = true
}

variable "TENANT_ID" {
  description = "The tenant ID"
}

# Provider configuration for Azure
provider "azurerm" {
  features {}

  subscription_id = var.SUBSCRIPTION_ID
  client_id       = var.CLIENT_ID
  client_secret   = var.CLIENT_SECRET
  tenant_id       = var.TENANT_ID
}

# Resource Group to hold resources
resource "azurerm_resource_group" "rg" {
  name     = "RG1"
  location = "East US"
}

# Virtual Network creation
resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# Subnet creation within the virtual network
resource "azurerm_subnet" "subnet" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Output the virtual network name for confirmation
output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

