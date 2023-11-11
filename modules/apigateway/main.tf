resource "aws_apigatewayv2_api" "api_gateway_http" {
  protocol_type = "HTTP"
  name          = local.api_name
  tags          = var.tags
}

resource "aws_apigatewayv2_stage" "api_gateway_stage" {
  api_id      = aws_apigatewayv2_api.api_gateway_http.id
  name        = "$default"
  auto_deploy = true
  depends_on  = [aws_apigatewayv2_api.api_gateway_http]
  tags        = var.tags
}

resource "aws_apigatewayv2_authorizer" "route_authorizer" {
  name                              = "${var.project_name}_lambda_authorizer"
  api_id                            = aws_apigatewayv2_api.api_gateway_http.id
  authorizer_type                   = "REQUEST"
  authorizer_uri                    = var.lambda_authorizer_invoke_arn
  authorizer_result_ttl_in_seconds  = 0
  authorizer_payload_format_version = "2.0"
}

resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "apigateway-invoke-permissions"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  function_name = "${var.project_name}-lambda-authorizer-${var.app_env}"
}

resource "aws_apigatewayv2_route" "apigw_route" {
  api_id        = aws_apigatewayv2_api.api_gateway_http.id
  route_key     = "ANY /{proxy+}"
  target        = "integrations/${aws_apigatewayv2_integration.apigw_integration.id}"
  authorizer_id = aws_apigatewayv2_authorizer.route_authorizer.id
  depends_on = [
    aws_apigatewayv2_authorizer.route_authorizer,
    aws_apigatewayv2_integration.apigw_integration,
    aws_lambda_permission.api_gateway_invoke,
  ]
  # authorization_scopes = ["scope1", "scope2"] # Scopes necessários (apenas para autorizador JWT)
}