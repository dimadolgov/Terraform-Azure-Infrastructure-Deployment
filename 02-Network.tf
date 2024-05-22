# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vmnet" {
  name                = "vmnet"
  resource_group_name = azurerm_resource_group.Resource_Group.name
  location            = azurerm_resource_group.Resource_Group.location
  address_space       = ["10.0.0.0/16"]
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "subnet_01" {
  name                 = "subnet_01"
  resource_group_name  = azurerm_resource_group.Resource_Group.name
  virtual_network_name = azurerm_virtual_network.vmnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "subnet_02" {
  name                 = "subnet_02"
  resource_group_name  = azurerm_resource_group.Resource_Group.name
  virtual_network_name = azurerm_virtual_network.vmnet.name
  address_prefixes     = ["10.0.2.0/24"]
}