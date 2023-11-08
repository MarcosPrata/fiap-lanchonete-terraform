locals {
  tags = {
    project                  = var.project_name,
    stage                    = var.app_env,
    managed-by               = "terraform"
    squad                    = "SOAT220"
  }
}
