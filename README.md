# Terraform Azure Infrastructure Deployment

This repository contains Terraform configuration files to deploy infrastructure resources on Azure, including virtual networks, subnets, virtual machines, public IP addresses, and network interfaces. 

KeyVault with `adminpassword` should be created earlier.


## Prerequisites

Before you begin, ensure you have the following:

- [Terraform](https://www.terraform.io/downloads.html) installed locally.
- Azure subscription with necessary permissions to create resources.

## Usage

Update the `00-provider.tf` file with your Azure credentials:

    provider "azurerm" {
      features {}
      client_id       = "<YOUR_CLIENT_ID>"
      client_secret   = "<YOUR_CLIENT_SECRET>"
      subscription_id = "<YOUR_SUBSCRIPTION_ID>"
      tenant_id       = "<YOUR_TENANT_ID>"
    }
    

## File Structure

- `00-provider.tf`: Defines the required provider and its version, along with Azure provider configuration.
- `01-Resource_Group.tf`: Creates a resource group in Azure.
- `02-Network.tf`: Creates a virtual network and subnets within the resource group.
- `04-KeyVault.tf`: Fetches admin password from Azure Key Vault.
- `05-Linux_VM.tf` and `05-Windows_VM.tf`: Create virtual machines for Linux and Windows in different subnets and uses password from KeyVault.

## Resources Created

- **Resource Group**: Used to group Azure resources.
- **Virtual Network**: Provides communication between Azure resources.
- **Subnets**: Segments the virtual network into smaller networks.
- **Azure Key Vault**: Securely stores secrets like passwords.
- **Virtual Machines (Linux and Windows)**: Compute resources for running applications.


