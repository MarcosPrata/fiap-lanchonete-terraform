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

variable "tags" {
  type        = map(string)
  description = "(Required) Tags de identificação do projeto"
}

variable "ecs_service_subnet_ids" {
  type        = set(string)
  description = "(Required) Id da subrede"
}

variable "application_port" {
  type        = string
  default     = "80"
  description = "(Optional) porta na qual o container espera ser chamado. default=80"
}

variable "load_balancer_target_group_arn" {
  type        = string
  description = "(Required) Arn do target group do load balancer"
}
