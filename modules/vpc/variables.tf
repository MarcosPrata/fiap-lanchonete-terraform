variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
  description = "(Required) vpc_cidr. default=10.0.0.0/16"
}

variable "tags" {
  type        = map(string)
  description = "(Required) Tags de identificação do projeto"
}