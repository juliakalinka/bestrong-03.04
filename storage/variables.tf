variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the Storage Account"
  type        = string
}

variable "fileshare_name" {
  description = "Name of the File Share"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for Storage Account"
  type        = string
}

variable "storage_pe_name" {
  description = "Name of the Storage Account Private Endpoint"
  type        = string
}

variable "storage_connection_name" {
  description = "Name of the Storage Account Private Service Connection"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default     = {}
}
