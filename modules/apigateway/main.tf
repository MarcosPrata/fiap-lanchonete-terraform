resource "aws_api_gateway_rest_api" "rest_api" {
  name = local.api_name
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_authorizer" "authorizer" {
  name                   = "${var.project_name}_lambda_authorizer"
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  type                   = "TOKEN"
  authorizer_uri          = var.lambda_authorizer_invoke_arn
  authorizer_credentials  = var.lambda_authorizer_access_role_arn
  identity_validation_expression = "^(Bearer)[ ]?(.*)$"
}

# resource "aws_api_gateway_integration" "integration" {
#   rest_api_id = aws_api_gateway_rest_api.rest_api.id
#   resource_id = aws_api_gateway_method.proxy.resource_id
#   http_method = aws_api_gateway_method.proxy.http_method

#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = module.lambda_authorizer.lambda_function_arn
# }

