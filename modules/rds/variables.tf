variable "project_name" {
  type        = string
  description = "(Required) Nome do projeto"
}

variable "app_env" {
  type        = string
  description = "(Required) Ambiente de implantação: dev, stg, prd."
}

variable "tags" {
  type        = map(string)
  description = "(Required) Tags de identificação do projeto"
}

variable "vpc_id" {
  type        = string
  description = "(Required) Id da vpc"
}

variable "subnet_ids" {
  type        = set(string)
  description = "(Required) Ids de subrede"
}