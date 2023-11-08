variable "app_env" {}

variable "project_name" {
  type = string
}

variable "tags" {}

variable "lambda_authorizer_invoke_arn" {
  type = string
}

variable "lambda_authorizer_access_role_arn" {
  type = string
}
