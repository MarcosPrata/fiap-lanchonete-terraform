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

variable "vpc_id" {
  type        = string
  description = "(Required) Id da vpc"
}

variable "application_port" {
  type        = string
  default     = "80"
  description = "(Optional) porta na qual o container espera ser chamado. default=80"
}

variable "incomming_load_balancer_port" {
  type        = string
  default     = "80"
  description = "(Optional) porta na qual o load balancer espera ser chamado. default=80"
}

variable "ecs_service_subnet_ids" {
  type        = set(string)
  description = "(Required) Id da subrede"
}

variable "load_balancer_subnet_ids" {
  type        = set(string)
  description = "(Required)"
}

variable "tags" {
  type        = map(string)
  description = "(Required) Tags de identificação do projeto"
}
