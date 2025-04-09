resource "azurerm_mssql_server" "bestrong_sql_server" {
  name                         = local.names.sql_server
  resource_group_name          = azurerm_resource_group.bestrong_rg.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = "1.2"

  public_network_access_enabled = false

  tags = local.tags
}

resource "azurerm_mssql_database" "bestrong_db" {
  name        = local.names.sql_db
  server_id   = azurerm_mssql_server.bestrong_sql_server.id
  sku_name    = "Basic"
  collation   = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb = 2

  tags = local.tags
}

resource "azurerm_private_endpoint" "sql_pe" {
  name                = local.names.sql_pe
  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  subnet_id           = azurerm_subnet.bestrong_subnet_sql.id

  private_service_connection {
    name                           = local.names.sql_connection
    private_connection_resource_id = azurerm_mssql_server.bestrong_sql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  tags = local.tags
}
