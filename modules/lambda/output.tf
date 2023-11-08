output "lambda_function_arn" {
  value = aws_lambda_function.lambda.arn
}

output "lambda_function_invoke_arn" {
  value = aws_lambda_function.lambda.invoke_arn
}