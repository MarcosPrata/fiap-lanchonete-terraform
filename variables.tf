variable "project_name" {
  type        = string
  default     = "lanchonete"
  description = "(Optional) Nome do projeto"
}

variable "app_env" {
  type        = string
  default     = "stg"
  description = "(Optional) Ambiente de implantação: dev, stg, prd."
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "(Optional) Região da AWS"
}

variable "aws_access_key" {
  type        = string
  description = "(Required) Chave de acesso de um usário com acesso para realizar as alterações necessárias"
}

variable "aws_secret_key" {
  type        = string
  description = "(Required) Chave de acesso secreta de um usário com acesso para realizar as alterações necessárias"
}