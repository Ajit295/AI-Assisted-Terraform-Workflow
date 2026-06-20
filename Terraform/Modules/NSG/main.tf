resource "azurerm_network_security_group" "NSG" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = var.security_rule_name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.destination_port_range
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_linking" {
  count = var.no_of_virtual_machines
  subnet_id                 = var.subnet_id[count.index]
  network_security_group_id = azurerm_network_security_group.NSG.id
}