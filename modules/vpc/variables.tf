variable "aws_region" {
  type        = string
  description = "(Required) Aws region."
}

variable "project_name" {
  type        = string
  description = "(Required) Nome do Projeto."
}

variable "app_env" {
  type        = string
  description = "(Required) Ambiente."
}

variable "tags" {
  type        = map(string)
  description = "(Required) Tags de identificação do projeto"
}