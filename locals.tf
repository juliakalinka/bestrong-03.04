locals {
  project     = "bestrong"
  environment = "dev" # prod/stage/test

  tags = {
    project     = local.project
    environment = local.environment
    owner       = "yulia.kalinka"
  }

  names = {
    resource_group             = "${local.project}-rg"
    vnet                       = "${local.project}-vnet"
    subnet_app                 = "${local.project}-subnet-app"
    subnet_sql                 = "${local.project}-subnet-sql"
    subnet_storage             = "${local.project}-subnet-storage"
    subnet_kv                  = "${local.project}-subnet-kv"
    subnet_app_pe              = "${local.project}-subnet-app-pe"
    app_service_plan           = "${local.project}-asp"
    app_service                = "${local.project}-app-service-bs1"
    app_service_pe             = "${local.project}-app-service-pe"
    app_service_connection     = "${local.project}-app-service-conn"
    app_insights               = "${local.project}-app-insights"
    acr                        = "${local.project}1acr1"
    key_vault                  = "${local.project}-kv1bs"
    key_vault_pe               = "${local.project}-kv-pe"
    key_vault_connection       = "${local.project}-kv-conn"
    sql_server                 = "${local.project}-sql"
    sql_db                     = "${local.project}-db1bs"
    sql_pe                     = "${local.project}-sql-pe"
    sql_connection             = "${local.project}-sql-conn"
    storage_account            = "${local.project}1sa1bs"
    storage_fileshare          = "${local.project}-fs-bs1"
    storage_private_endpoint   = "${local.project}-storage-pe"
    storage_service_connection = "${local.project}-storage-conn"
    terraform_state_account    = "${local.project}tfstateaccount"
    terraform_state_container  = "${local.project}tfstatecontainer"
  }
}
