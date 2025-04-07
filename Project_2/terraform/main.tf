resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  address_space       = var.address_space  # Now uses the variable
  location            = azurerm_resource_group.vnet_rg.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
}
