resource "azurerm_resource_group" "this" {
  name     = "sql-resources"
  location = "East US"
}

#resource "azurerm_storage_account" "example" {
  #name                     = "examplesa"
  #resource_group_name      = azurerm_resource_group.example.name
  #location                 = azurerm_resource_group.example.location
  #account_tier             = "Standard"
  #account_replication_type = "LRS"
#}

resource "azurerm_sql_server" "this" {
  name                         = "sql-sqlserver1238947"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = azurerm_resource_group.this.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_mssql_database" "primary" {
  name           = "sql-db-primary8878"
  server_id      = azurerm_sql_server.this.id
  create_mode    = "PointInTimeRestore"
  sku_name = "DW100c"
  restore_point_in_time = "2021-03-10T14:09:07Z"
  creation_source_database_id = azurerm_mssql_database.primary.id
}

#resource "azurerm_mssql_database" "secondary" {
  #name           = "sql-db-secondary8878"
  #server_id      = azurerm_sql_server.this.id
  #creation_source_database_id = azurerm_mssql_database.primary.id
  #create_mode    = "OnlineSecondary"

  #sku_name = "DW100c"
#}