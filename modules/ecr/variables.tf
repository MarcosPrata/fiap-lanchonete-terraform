variable "project_name" {
  type        = string
  description = "(Required) Nome do projeto"
}

variable "app_env" {
  type        = string
  description = "(Optional) Ambiente de implantação: dev, stg, prd. default=prod"
  default     = "prod"
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Tags de identificação do projeto"
  default     = {}
}

variable "image_tag_mutability" {
  type        = string
  description = "(Optional) A configuração de mutabilidade da tag para o repositório. Deve ser um dos: MUTABLE (mutável) ou IMMUTABLE (imutável). O padrão é MUTABLE (mutável)."
  default     = "MUTABLE"
}

variable "scan_on_push" {
  type        = bool
  description = "(Required) Indica se as imagens são verificadas após serem enviadas para o repositório (verdadeiro) ou não verificadas (falso)."
  default     = true
}

variable "expiration_after_days" {
  type        = number
  description = "(Optional) Deleta as imagens mais velhas que X dias. default 0"
  default     = 0
}
