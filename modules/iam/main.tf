resource "aws_iam_user" "apigateway" {
  name = "lanchonete_apigateway_deploy_user_${var.app_env}"

  tags = merge(
    { app = "github-actions" },

    var.tags
  )
}

resource "aws_iam_access_key" "apigateway" {
  user = aws_iam_user.apigateway.name
}

resource "aws_iam_user_policy" "apigateway" {
  name = "lanchonete_apigateway_policy_${var.app_env}"
  user = aws_iam_user.apigateway.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": "apigateway:*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "policy" {
  name        = "${var.project_name}-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = ["arn:aws:logs:*:*:*"]
    },{
      Effect = "Allow"
      Action = [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface"
      ]
      Resource = ["*"]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  policy_arn = aws_iam_policy.policy.arn
  role = aws_iam_role.lambda_role.name
}
