# Create resource group
resource "azurerm_resource_group" "sldt_rg" {
  name     = "${var.prefix}-rg"
  location = "${var.region}"
}

# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = azurerm_resource_group.sldt_rg.location
  address_space       = [var.address_space]
  resource_group_name = azurerm_resource_group.sldt_rg.name
}

# Create subnet
resource "azurerm_subnet" "public_subnet" {
  name                 = "${var.prefix}-pub-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.sldt_rg.name
  address_prefixes     = [var.pub_subnet_prefix]

  service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
}

# Create Network Security Group and rule(bastion)
resource "azurerm_network_security_group" "bastion_nsg" {
  name                = "${var.prefix}-bastion-nsg"
  location            = azurerm_resource_group.sldt_rg.location
  resource_group_name = azurerm_resource_group.sldt_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface(bastion)
resource "azurerm_network_interface" "bastion_nic" {
  name                = "${var.prefix}-bastion-nic"
  location            = azurerm_resource_group.sldt_rg.location
  resource_group_name = azurerm_resource_group.sldt_rg.name

  ip_configuration {
    name                          = "${var.prefix}-nic-configuration"
    subnet_id                     = azurerm_subnet.public_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_pip.id
  }
}

# Connect the security group to the network interface(bastion)
resource "azurerm_network_interface_security_group_association" "bastion_nic_sg_asso" {
  network_interface_id      = azurerm_network_interface.bastion_nic.id
  network_security_group_id = azurerm_network_security_group.bastion_nsg.id
}

# Create public ip(bastion)
resource "azurerm_public_ip" "bastion_pip" {
  name                = "${var.prefix}-pip"
  location            = azurerm_resource_group.sldt_rg.location
  resource_group_name = azurerm_resource_group.sldt_rg.name
  allocation_method   = "Static"
  domain_name_label   = "${var.prefix}-bastion-pip-${random_id.bastion_pip.hex}"
}

# Create virtual machine(bastion)
resource "azurerm_linux_virtual_machine" "bastion" {
  name                = "${var.prefix}-bastion-vm"
  location            = azurerm_resource_group.sldt_rg.location
  resource_group_name = azurerm_resource_group.sldt_rg.name
  network_interface_ids = [azurerm_network_interface.bastion_nic.id]
  size                = var.vm_size[0]
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = "30"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  admin_username      = var.vm_username
  computer_name       = "bastion"

  admin_ssh_key {
    username   = var.vm_username
    public_key = file("sshkey/sldt_rsa.pub")
  }

  tags = {
    Name        = "${var.prefix}-bastion-vm"
    environment = var.environment
  }

  depends_on = [azurerm_network_interface_security_group_association.bastion_nic_sg_asso]
}