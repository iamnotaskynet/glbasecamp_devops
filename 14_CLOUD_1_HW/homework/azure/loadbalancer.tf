provider "azurerm" {
  version = "=2.40.0"
  features {}
}
# RSOURCE GROUP 
resource "azurerm_resource_group" "rg" {
  name     = "rg"
  location = "West US"
}
# VIRUAL NETWORK
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
# SUBNET 1
resource "azurerm_subnet" "subnet1" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
# SUBNET 2
resource "azurerm_subnet" "subnet1" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
# NETWORK INTERFACE 1
resource "azurerm_network_interface" "nic1" {
  name                = "nic1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}
# NETWORK INTERFACE 2
resource "azurerm_network_interface" "nic2" {
  name                = "nic2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}
# NETWORK SECURITY GROUP
resource "azurerm_network_security_group" "netsec" {
  name                = "netsec"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow80"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = { environment = "Production" }
}
# INSTANCE 1
resource "azurerm_linux_virtual_machine" "ubu1" {
  name                = "ubu1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [ azurerm_network_interface.nic1.id ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

  os_profile {
    admin_username = "adminuser"
    computer_name  = "ubu1"
    custom_data    = file("../ubu1nginx.bash")
  }
}
# INSTANCE 2
resource "azurerm_linux_virtual_machine" "ubu2" {
  name                = "ubu2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [ azurerm_network_interface.nic2.id ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

  os_profile {
    admin_username = "adminuser"
    computer_name  = "ubu2"
    custom_data    = file("../ubu2nginx.bash")
  }
}
# PUBLIC IP (for loadbalancer)
resource "azurerm_public_ip" "pubip" {
  name                = "pubip"
  location            = "West US"
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}
# LOADBALANCER
resource "azurerm_lb" "loadbalancer" {
  name                = "loadbalancer"
  location            = "West US"
  resource_group_name = azurerm_resource_group.rg.name

  frontend_ip_configuration {
    name                 = "pubip"
    public_ip_address_id = azurerm_public_ip.pubip.id
  }
}
# LOADBALANCER RULE
resource "azurerm_lb_rule" "lbrule" {
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "lbrule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "pubip"
}