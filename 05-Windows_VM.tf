# Create a virtual machine
resource "azurerm_virtual_machine" "vm_windows01" {
  name                  = "Windows01"
  location              = "Israel Central"
  resource_group_name   = azurerm_resource_group.Resource_Group.name
  network_interface_ids = [azurerm_network_interface.nic_windows01.id]
  vm_size               = "Standard_B1s"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name  = "windows01"
    admin_username = "adminuser"
    admin_password = data.azurerm_key_vault_secret.adminpassword.value
  }

  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
  }

  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  tags = {
    environment = "test"
  }
}

# Create a public IP address for the Windows VM
resource "azurerm_public_ip" "vm_public_ip_windows01" {
  name                = "vm_public_ip"
  location            = azurerm_resource_group.Resource_Group.location
  resource_group_name = azurerm_resource_group.Resource_Group.name
  allocation_method   = "Dynamic"
}

# Create a network interface for the Windows VM
resource "azurerm_network_interface" "nic_windows01" {
  name                      = "nic_windows01"
  location                  = azurerm_resource_group.Resource_Group.location
  resource_group_name       = azurerm_resource_group.Resource_Group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip_windows01.id
  }
}

