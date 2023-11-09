resource "aws_apigatewayv2_api" "apigw_http_endpoint" {
  name          = local.api_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_route" "apigw_route" {
  api_id     = aws_apigatewayv2_api.apigw_http_endpoint.id
  route_key  = "ANY /{proxy+}"
  target     = "integrations/${aws_apigatewayv2_integration.apigw_integration.id}"
  depends_on = [aws_apigatewayv2_integration.apigw_integration]
}
resource "aws_apigatewayv2_stage" "apigw_stage" {
  api_id      = aws_apigatewayv2_api.apigw_http_endpoint.id
  name        = "$default"
  auto_deploy = true
  depends_on  = [aws_apigatewayv2_api.apigw_http_endpoint]
}

output "apigw_endpoint" {
  value       = aws_apigatewayv2_api.apigw_http_endpoint.api_endpoint
  description = "API Gateway Endpoint"
}

# resource "aws_api_gateway_authorizer" "authorizer" {
#   name                   = "${var.project_name}_lambda_authorizer"
#   rest_api_id             = aws_api_gateway_rest_api.rest_api.id
#   type                   = "TOKEN"
#   authorizer_uri          = var.lambda_authorizer_invoke_arn
#   authorizer_credentials  = var.lambda_authorizer_access_role_arn
#   identity_validation_expression = "^(Bearer)[ ]?(.*)$"
# }
