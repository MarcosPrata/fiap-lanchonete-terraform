locals {
  db_name    = "${var.project_name}-db"

  tags = {
    project                  = var.project_name,
    stage                    = var.app_env,
    managed-by               = "terraform"
    squad                    = "SOAT220"
  }
}
