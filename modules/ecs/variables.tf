variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "(Optional) Aws region. default=us-east-1"
}

variable "project_name" {
  type        = string
  description = "(Required) Nome do Projeto."
}

variable "app_env" {
  type        = string
  description = "(Required) Ambiente."
}

variable "vpc_id" {
  type        = string
  description = "(Required) Id da vpc"
}

variable "subnet_ids" {
  type        = set(string)
  description = "(Required) Id da subrede"
}

variable "subnet_id" {
  type        = string
  description = "(Required) Id da subrede"
}