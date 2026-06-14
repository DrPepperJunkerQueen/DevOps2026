resource "azurerm_container_registry" "acr" {
  name                          = "${var.prefix}acr"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  sku                           = "Premium"
  admin_enabled                 = false
  public_network_access_enabled = false  # ACR dostepny wylacznie przez private endpoint
}

resource "azurerm_private_dns_zone" "acr_dns" {
  name                = "privatelink.azurecr.io"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr_dns_link" {
  name                  = "${var.prefix}-acr-dns-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.acr_dns.name
  registration_enabled  = false

  # Podłączenie sieci VNet do strefy DNS, aby maszyna wirtualna mogła rozwiązywać nazwę ACR na prywatny IP.
  virtual_network_id = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_endpoint" "acr_pe" {
  name                = "${var.prefix}-acr-pe"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "${var.prefix}-acr-psc"
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false

    # Dla Azure Container Registry jedyna dostępna wartość w tej liście to "registry".
    subresource_names = ["registry"]
  }

  private_dns_zone_group {
    name = "acr-dns-zone-group"

    # Podłączenie prywatnej strefy DNS do private endpoint, aby rekordy A tworzyły się automatycznie.
    private_dns_zone_ids = [azurerm_private_dns_zone.acr_dns.id]
  }
}