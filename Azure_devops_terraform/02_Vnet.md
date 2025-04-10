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


🛠️ Automate with Azure DevOps
To integrate Terraform with Azure DevOps, follow these steps:

🟡 Step 1: Create an Azure DevOps Service Connection
Go to Azure DevOps → Project Settings → Service connections
Create a new Azure Resource Manager (ARM) service connection
Use Service Principal (automatic) authentication
🟡 Step 2: Define the Azure DevOps Pipeline (azure-pipelines.yml)

```
trigger:
- main

variables:
- group: terraform_credential  # contains CLIENT_ID, CLIENT_SECRET, SUBSCRIPTION_ID, TENANT_ID
- name: terraformVersion
  value: '1.5.5'

pool:
  vmImage: 'ubuntu-latest'
  timeoutInMinutes: 30

steps:
# ✅ Install Terraform
- script: |
    curl -LO https://releases.hashicorp.com/terraform/$(terraformVersion)/terraform_$(terraformVersion)_linux_amd64.zip
    unzip terraform_$(terraformVersion)_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
    terraform -version
  displayName: 'Install Terraform'

# ✅ Terraform Init
- script: |
    export ARM_CLIENT_ID=$(CLIENT_ID)
    export ARM_CLIENT_SECRET=$(CLIENT_SECRET)
    export ARM_SUBSCRIPTION_ID=$(SUBSCRIPTION_ID)
    export ARM_TENANT_ID=$(TENANT_ID)

    terraform init
  displayName: 'Terraform Init'
  env:
    CLIENT_ID: $(CLIENT_ID)
    CLIENT_SECRET: $(CLIENT_SECRET)
    SUBSCRIPTION_ID: $(SUBSCRIPTION_ID)
    TENANT_ID: $(TENANT_ID)

# ✅ Terraform Plan
- script: |
    export ARM_CLIENT_ID=$(CLIENT_ID)
    export ARM_CLIENT_SECRET=$(CLIENT_SECRET)
    export ARM_SUBSCRIPTION_ID=$(SUBSCRIPTION_ID)
    export ARM_TENANT_ID=$(TENANT_ID)

    terraform plan
  displayName: 'Terraform Plan'
  env:
    CLIENT_ID: $(CLIENT_ID)
    CLIENT_SECRET: $(CLIENT_SECRET)
    SUBSCRIPTION_ID: $(SUBSCRIPTION_ID)
    TENANT_ID: $(TENANT_ID)

# ✅ Terraform Apply
- script: |
    export ARM_CLIENT_ID=$(CLIENT_ID)
    export ARM_CLIENT_SECRET=$(CLIENT_SECRET)
    export ARM_SUBSCRIPTION_ID=$(SUBSCRIPTION_ID)
    export ARM_TENANT_ID=$(TENANT_ID)

    terraform apply -auto-approve
  displayName: 'Terraform Apply'
  env:
    CLIENT_ID: $(CLIENT_ID)
    CLIENT_SECRET: $(CLIENT_SECRET)
    SUBSCRIPTION_ID: $(SUBSCRIPTION_ID)
    TENANT_ID: $(TENANT_ID)

✅ Verify the Deployment
After applying Terraform, verify the deployment in Azure Portal:

Navigate to → Azure Portal
Go to → Virtual network
Search for → Vnet
OR, use the Azure CLI:
az group show --name virtual-net

