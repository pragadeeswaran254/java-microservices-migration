terraform {
  required_providers {
    azurerm = { 
      source  = "hashicorp/azurerm"
      version = "~>3.0" 
    }
  }
}

provider "azurerm" { 
  features {} 
}

# 1. Your Existing Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "petclinic-rg" 
  location = "eastus"
}

# 2. Your Existing Container Vault (ACR)
resource "azurerm_container_registry" "acr" {
  name                = "gnbala9614" 
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = true
}

# 3. YOUR NEW PRODUCTION KUBERNETES CLUSTER (AKS)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "petclinic-aks-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "petclinicaks"

  default_node_pool {
    name       = "default"
    node_count = 1                  
    vm_size    = "Standard_DC2s_v3"  # 2 vCPUs, 16GB RAM (Allowed in your quota)
  }

  identity { type = "SystemAssigned" }
}