# Testing
resource "azurerm_resource_group" "bestrong_rg" {
  name     = local.names.resource_group
  location = var.location
  tags     = local.tags
}

module "network" {
  source = "./network"

  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  vnet_name           = local.names.vnet
  vnet_address_space  = ["10.0.0.0/16"]

  subnet_app_name              = local.names.subnet_app
  subnet_app_address_prefixes  = ["10.0.1.0/24"]
  subnet_sql_name              = local.names.subnet_sql
  subnet_sql_address_prefixes  = ["10.0.2.0/24"]
  subnet_storage_name          = local.names.subnet_storage
  subnet_storage_address_prefixes = ["10.0.3.0/24"]
  subnet_kv_name               = local.names.subnet_kv
  subnet_kv_address_prefixes   = ["10.0.4.0/24"]
  subnet_pe_name               = local.names.subnet_app_pe
  subnet_pe_address_prefixes   = ["10.0.5.0/24"]

  tags = local.tags
}

module "app_service" {
  source = "./app_service"

  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  app_service_plan_name = local.names.app_service_plan
  app_service_plan_sku  = var.app_service_plan_sku
  app_service_name      = local.names.app_service
  app_service_pe_name   = local.names.app_service_pe
  app_service_connection_name = local.names.app_service_connection

  app_insights_instrumentation_key = module.monitoring.instrumentation_key
  app_insights_connection_string   = module.monitoring.connection_string
  storage_account_name             = module.storage.storage_account_name
  storage_account_key              = module.storage.storage_account_key
  fileshare_name                   = module.storage.fileshare_name

  private_endpoint_subnet_id = module.network.subnet_pe_id
  app_subnet_id             = module.network.subnet_app_id

  tags = local.tags
}

module "storage" {
  source = "./storage"

  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  storage_account_name = local.names.storage_account
  fileshare_name       = local.names.storage_fileshare
  subnet_id            = module.network.subnet_storage_id
  storage_pe_name      = local.names.storage_private_endpoint
  storage_connection_name = local.names.storage_service_connection

  tags = local.tags
}

module "sql" {
  source = "./sql"

  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  sql_server_name     = local.names.sql_server
  sql_database_name   = local.names.sql_db
  sql_admin_username  = var.sql_admin_username
  sql_admin_password  = var.sql_admin_password
  subnet_id           = module.network.subnet_sql_id

  tags = local.tags
}

module "key_vault" {
  source = "./key_vault"

  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  key_vault_name      = local.names.key_vault
  subnet_id           = module.network.subnet_kv_id
  app_service_principal_id = module.app_service.app_service_identity_principal_id

  tags = local.tags
}

module "container_registry" {
  source = "./container_registry"

  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  acr_name            = local.names.acr
  app_service_principal_id = module.app_service.app_service_identity_principal_id

  tags = local.tags
}

module "monitoring" {
  source = "./monitoring"

  location            = var.location
  resource_group_name = azurerm_resource_group.bestrong_rg.name
  app_insights_name   = local.names.app_insights

  tags = local.tags
}
