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

variable "ecs_vpc_id" {
  type        = string
  description = "(Required) Id da vpc"
}

variable "ecs_service_subnet_id" {
  type        = string
  description = "(Required) Id da subrede"
}