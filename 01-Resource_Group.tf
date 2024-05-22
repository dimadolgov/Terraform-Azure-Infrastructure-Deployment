# Create a resource group in Azure
resource "azurerm_resource_group" "Resource_Group" {
  name     = "Resource_Group"
  location = "Israel Central"
}