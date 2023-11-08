variable "app_env" {
  type        = string
  description = "(Required) Ambiente de implantação: dev, stg, prd."
}

variable "project_name" {
  type = string
  description = "(Required) Nome do projeto"
}

variable "tags" {
  type = map(string)
  description = "(Required) Tags de identificação do projeto"
}

variable "lambda_authorizer_invoke_arn" {
  type = string
  description = "(Required) Arn de invocação do lambda authorizer"
}

variable "lambda_authorizer_access_role_arn" {
  type = string
  description = "(Required) Arn da role de acesso da lambda de autorização"
}
