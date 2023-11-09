module "vpc" {
  source = "./modules/vpc"
  tags   = local.tags
}

module "rds" {
  source       = "./modules/rds"
  tags         = local.tags
  project_name = var.project_name
  app_env      = var.app_env
  vpc_id       = module.vpc.vpc_id
  subnet_ids = [
    module.vpc.private_subnet1_id,
    module.vpc.private_subnet2_id
  ]
}

module "iam" {
  source       = "./modules/iam"
  app_env      = var.app_env
  tags         = local.tags
  region       = var.aws_region
  project_name = var.project_name
}

module "lambda_authorizer" {
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
  lambda_authorizer_invoke_arn      = module.lambda_authorizer.lambda_function_invoke_arn
  lambda_authorizer_access_role_arn = module.iam.iam_lambda_role
  ecs_alb_listener_arn              = module.ecs.ecs_alb_listener_arn
  subnet_ids = [
    module.vpc.private_subnet1_id,
    module.vpc.private_subnet2_id
  ]
}

module "ecr" {
  source                = "./modules/ecr"
  app_env               = var.app_env
  project_name          = var.project_name
  tags                  = local.tags
  image_tag_mutability  = "MUTABLE"
  scan_on_push          = true
  expiration_after_days = 7
}

module "ecs" {
  source       = "./modules/ecs"
  aws_region   = var.aws_region
  app_env      = var.app_env
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.public_subnet_id
  subnet_ids = [
    module.vpc.private_subnet1_id,
    module.vpc.private_subnet2_id
  ]
}
