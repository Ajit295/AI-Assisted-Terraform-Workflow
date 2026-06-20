output "NIC_id_output" {
    value = azurerm_network_interface.example[*].id
}