variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "(Optional) Aws region. default=us-east-1"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "(Optional) CIDR block. default=10.0.0.0/16"
}

variable "availability_zones" {
  type    = string
  default = "us-east-1a"
  description = "(Optional) Zona de disponibilidade. default=us-east-1a"
}