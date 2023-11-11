variable "app_env" {
  type        = string
  description = "(Required) Ambiente de implantação: dev, stg, prd."
}

variable "aws_region" {
  type        = string
  description = "(Required) AWS Region"
}

variable "project_name" {
  type        = string
  description = "(Required) Nome do projeto"
}

variable "tags" {
  type        = map(string)
  description = "(Required) Tags de identificação do projeto"
}

variable "cluster_subnet_ids" {
  type        = set(string)
  description = "(Required) Subnets do cluster do eks"
}