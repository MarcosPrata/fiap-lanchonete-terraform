variable "app_env" {
  type        = string
  description = "(Required) Ambiente de implantação: dev, stg, prd."
}

variable "project_name" {
  type        = string
  description = "(Required) Nome do projeto"
}

variable "region" {
  type        = map(string)
  description = "(Required) AWS Region"
}

variable "tags" {
  type        = map(string)
  description = "(Required) Tags de identificação do projeto"
}
