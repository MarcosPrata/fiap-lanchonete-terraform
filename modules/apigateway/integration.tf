resource "aws_apigatewayv2_vpc_link" "vpclink_apigw_to_alb" {
  name               = "vpclink_apigateway_to_alb"
  security_group_ids = [aws_security_group.vpc_link_security_group.id]
  subnet_ids         = var.subnet_ids
}

resource "aws_apigatewayv2_integration" "apigw_integration" {
  api_id                 = aws_apigatewayv2_api.api_gateway_http.id
  integration_type       = "HTTP_PROXY"
  integration_uri        = var.alb_listener_arn
  integration_method     = "ANY"
  connection_type        = "VPC_LINK"
  connection_id          = aws_apigatewayv2_vpc_link.vpclink_apigw_to_alb.id
  payload_format_version = "1.0"
  depends_on = [
    aws_apigatewayv2_vpc_link.vpclink_apigw_to_alb,
    aws_apigatewayv2_api.api_gateway_http
  ]
}
