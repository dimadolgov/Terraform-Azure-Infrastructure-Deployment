# Create a virtual machine for Linux
resource "azurerm_virtual_machine" "vm_linux01" {
  name                  = "Linux01"
  location              = "Israel Central"
  resource_group_name   = azurerm_resource_group.Resource_Group.name
  network_interface_ids = [azurerm_network_interface.nic_linux01.id]
  vm_size               = "Standard_B1s"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "linux01"
    admin_username = "adminuser"
    admin_password = data.azurerm_key_vault_secret.adminpassword.value
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_os_disk {
    name              = "osdisk_linux01"  # Provide a unique name for the OS disk
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  tags = {
    environment = "test"
  }
}

# Create a public IP address for the Linux VM
resource "azurerm_public_ip" "vm_public_ip_linux01" {
  name                = "vm_public_ip_linux01"
  location            = azurerm_resource_group.Resource_Group.location
  resource_group_name = azurerm_resource_group.Resource_Group.name
  allocation_method   = "Dynamic"
}

# Create a network interface for the Linux VM
resource "azurerm_network_interface" "nic_linux01" {
  name                      = "nic_linux01"
  location                  = azurerm_resource_group.Resource_Group.location
  resource_group_name       = azurerm_resource_group.Resource_Group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_02.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip_linux01.id
  }
}