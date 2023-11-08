data "archive_file" "lambda_package" {
  type        = "zip"
  source_file = "./modules/lambda/index.js"
  output_path = "./modules/lambda/lambda.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name    = local.lambda_authorizer_name
  role             = var.lambda_role_arn
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
  filename         = "./modules/lambda/lambda.zip"
  handler          = "index.handler"
  runtime          = "nodejs14.x"
}