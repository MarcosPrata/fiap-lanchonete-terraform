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
variable "lambda_role_arn" {
  type        = string
  description = "(Required) ARN da role da lambda"
}
