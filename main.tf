module "rds" {
  source    = "./modules/rds"
  tags      = local.tags
  db_name = local.db_name
}