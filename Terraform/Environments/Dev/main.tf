# module "ResourceGroup" {
#    source = "../../Modules/ResourceGroup"
#    base_name = "Demo"
#    location = "North Europe"
# }

# module "VirtualNetwork" {
#     source = "../../Modules/VirtualNetwork"
#     VNET_Name = "Ajit-Vnet"
#     resource_group_name = module.ResourceGroup.rg_name_output
#     location = module.ResourceGroup.location_output
#     depends_on = [module.ResourceGroup]
# }

# module "Subnet" {
#     source = "../../Modules/Subnets"
#     subnet_name = "Subnet"
#     resource_group_name = module.ResourceGroup.rg_name_output
#     virtual_network_name = module.VirtualNetwork.Vnet_name_output
#     no_of_virtual_machines = var.no_of_virtual_machines
#     depends_on = [module.ResourceGroup, module.VirtualNetwork]
# }

# module "PublicIP" {
#     source = "../../Modules/PublicIP"
#     pip_name = "Ajit-pip"
#     resource_group_name = module.ResourceGroup.rg_name_output
#     location = module.ResourceGroup.location_output
#     depends_on = [module.ResourceGroup]
#     no_of_virtual_machines = var.no_of_virtual_machines

# }

# module "NetworkInterface" {
#     source = "../../Modules/NetworkInterface"
#     resource_group_name = module.ResourceGroup.rg_name_output
#     location = module.ResourceGroup.location_output
#     nic_name = "Ajit-NIC"
#     subnet_id = module.Subnet.subnet_id
#     public_ip_address_id = module.PublicIP.public_ip_address_id_output
#     depends_on = [module.ResourceGroup, module.Subnet, module.PublicIP]
#     no_of_virtual_machines = var.no_of_virtual_machines
# }

# module "NSG" {
#     source = "../../Modules/NSG"
#     nsg_name = "Ajit-NSG"
#     resource_group_name = module.ResourceGroup.rg_name_output
#     location = module.ResourceGroup.location_output
#     security_rule_name = "Allow-RDP"
#     destination_port_range = "3389"
#     subnet_id = module.Subnet.subnet_id
#     depends_on = [module.ResourceGroup, module.Subnet]
#     no_of_virtual_machines = var.no_of_virtual_machines
# }

# module "VirtualMachine" {
#     source = "../../Modules/VirtualMachine"
#     vm_name = "Ajit-VM"
#     resource_group_name = module.ResourceGroup.rg_name_output
#     location = module.ResourceGroup.location_output
#     NIC_id = module.NetworkInterface.NIC_id_output
#     depends_on = [module.ResourceGroup, module.NetworkInterface]
#     no_of_virtual_machines = var.no_of_virtual_machines

# }

# module "SQLDatabase" {
#     source = "../../Modules/SQLDatabase"
#     resource_group_name = module.ResourceGroup.rg_name_output
#     location = module.ResourceGroup.location_output
#     dbapp_environment = var.dbapp_environment
#     start_ip_address = "20.204.187.56"
#     end_ip_address = "20.204.187.56"
#     depends_on = [module.ResourceGroup]
# }

# module "Webapp" {
#     source = "../../Modules/Webapp"
#     resource_group_name = module.ResourceGroup.rg_name_output
#     location = module.ResourceGroup.location_output
#     webapp_environment = var.webapp_environment
#     depends_on = [module.ResourceGroup]
# }


# module "StorageAccount" {
#   source = "../../Modules/StorageAccount"
#   storage_account_name     = var.storage_account_name
#   resource_group_name      = module.ResourceGroup.rg_name_output
#   location                 = module.ResourceGroup.location_output
#   account_tier             = var.storage_account_tier
#   account_replication_type = var.storage_replication_type
#   depends_on = [module.ResourceGroup]
# }

# module "webapp" {
#    source = "../../Modules/webapp"
#    resource_group_name = module.ResourceGroup.rg_name_output
#    location = module.ResourceGroup.location_output
# }
