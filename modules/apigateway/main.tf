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
  authorizer_uri          = var.lambda_authorizer_arn
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


# data "template_file" "_" {
#   template = var.api_template

#   vars = var.api_template_vars
# }



# resource "aws_api_gateway_rest_api" "_" {
#   name           = var.api_name
#   api_key_source = "HEADER"
#   lifecycle {
#     ignore_changes = [name, ]
#   }

#   body = data.template_file._.rendered
# }

# resource "aws_api_gateway_deployment" "_" {
#   rest_api_id = aws_api_gateway_rest_api._.id
#   stage_name  = var.app_env
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_api_gateway_stage" "_" {
#   stage_name    = var.app_env
#   rest_api_id   = aws_api_gateway_rest_api._.id
#   deployment_id = aws_api_gateway_deployment._.id

#   lifecycle {
#     ignore_changes = [deployment_id, ]
#   }

#   tags = var.tags
# }

# resource "aws_api_gateway_method_settings" "_" {
#   rest_api_id = aws_api_gateway_rest_api._.id
#   stage_name  = aws_api_gateway_stage._.stage_name
#   method_path = "*/*"
#   settings {}
# }
