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
  name = "${var.project_name}-policy"
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
      }, {
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
  role       = aws_iam_role.lambda_role.name
}


resource "aws_iam_role" "task_definition_role" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "ecr_policy" {
  name        = "ECRAuthorizationPolicy"
  description = "Policy for ECR authorization token"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ecr:*",
          "ecs:*",
          "logs:*",
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_ecr_policy" {
  policy_arn = aws_iam_policy.ecr_policy.arn
  role       = aws_iam_role.task_definition_role.name
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/lanchonete-api-${var.app_env}"
  retention_in_days = 7  
}