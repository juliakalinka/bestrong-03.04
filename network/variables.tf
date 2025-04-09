variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "subnet_app_name" {
  description = "Name of the App Service subnet"
  type        = string
}

variable "subnet_app_address_prefixes" {
  description = "Address prefixes for the App Service subnet"
  type        = list(string)
}

variable "subnet_sql_name" {
  description = "Name of the SQL subnet"
  type        = string
}

variable "subnet_sql_address_prefixes" {
  description = "Address prefixes for the SQL subnet"
  type        = list(string)
}

variable "subnet_storage_name" {
  description = "Name of the Storage subnet"
  type        = string
}

variable "subnet_storage_address_prefixes" {
  description = "Address prefixes for the Storage subnet"
  type        = list(string)
}

variable "subnet_kv_name" {
  description = "Name of the Key Vault subnet"
  type        = string
}

variable "subnet_kv_address_prefixes" {
  description = "Address prefixes for the Key Vault subnet"
  type        = list(string)
}

variable "subnet_pe_name" {
  description = "Name of the Private Endpoint subnet"
  type        = string
}

variable "subnet_pe_address_prefixes" {
  description = "Address prefixes for the Private Endpoint subnet"
  type        = list(string)
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}
