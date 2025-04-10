# 📝 Overview

This guide explains how to create an **Azure Virtual Network (VNET)** using **Terraform**.

The Terraform configuration files are stored in a **GitHub repository**, and the deployment process is fully automated using **Azure DevOps Pipelines**.


# 🎯 Objectives

- Set up **Terraform** to deploy an **Azure Virtual Network (VNET)**.
- Automate the deployment using **Azure DevOps Pipelines**.
- Ensure adherence to **Infrastructure as Code (IaC)** best practices.


📂 Project Structure
📁 Azure_devops_terraform/ │── main.tf # Terraform configuration file │── azure-pipelines.yml # Azure DevOps pipeline for automation

🛠 Terraform Configuration (main.tf)

🛠 Terraform Configuration (main.tf)
```
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
} 
