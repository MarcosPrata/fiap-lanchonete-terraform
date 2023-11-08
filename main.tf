module "rds" {
  source       = "./modules/rds"
  tags         = local.tags
  project_name = var.project_name
}

module "iam" {
  source       = "./modules/iam"
  app_env      = var.app_env
  tags         = local.tags
  region       = var.aws_region
  project_name = var.project_name
}

module "lambda" {
  source          = "./modules/lambda"
  app_env         = var.app_env
  aws_region      = var.aws_region
  project_name    = var.project_name
  tags            = local.tags
  lambda_role_arn = module.iam.iam_lambda_role
}

module "apigateway" {
  source                            = "./modules/apigateway"
  app_env                           = var.app_env
  project_name                      = var.project_name
  tags                              = local.tags
  lambda_authorizer_arn             = module.lambda.lambda_function_arn
  lambda_authorizer_access_role_arn = module.iam.iam_lambda_role
}


module "ecr" {
  source                = "./modules/ecr"
  app_env               = var.app_env
  project_name          = var.project_name
  tags                  = local.tags
  image_tag_mutability  = "IMMUTABLE"
  scan_on_push          = true
  expiration_after_days = 7
}
