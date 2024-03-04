resource "azurerm_resource_group" "rg1" {
  name     = var.resource_group_name
  location = "australiaeast"
}
resource "azurerm_network_security_group" "nsg1" {
  name                = "acc-nsg"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}
resource "azurerm_virtual_network" "vn1" {
  name                = var.vn-02
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = var.address_space
}
resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet-o2
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vn1.name
  address_prefixes     = var.address_prefixes
}
resource "azurerm_network_interface" "nic1" {
  name                = var.nic-02
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "vm1" {
  name                = var.vm-02
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = "Standard_B1s"

  admin_username                  = "azure-acc-user"
  admin_password                  = "Cloud@123"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic1.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 100

  }

  identity {
    type = "SystemAssigned"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  zone = "1"
}
