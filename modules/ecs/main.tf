resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project_name}-${var.app_env}-cluster"
  tags = var.tags
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.project_name}-task-definition"
  network_mode             = "awsvpc" #Cria o Elastic Network Interface
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 1024
  execution_role_arn       = aws_iam_role.ecs_task_exec_role.arn
  # task_role_arn          = aws_iam_role.ecs_task_role.arn é opcional
  tags = var.tags
  container_definitions = jsonencode([
    {
      name      = "${var.project_name}-${var.app_env}-container"
      image     = "nginx"
      essential = true
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "ecs_service" {
  name                              = "${var.project_name}-${var.app_env}-service"
  cluster                           = aws_ecs_cluster.ecs_cluster.id
  task_definition                   = aws_ecs_task_definition.ecs_task_definition.arn
  health_check_grace_period_seconds = 40
  desired_count                     = 1
  launch_type                       = "FARGATE"
  platform_version                  = "LATEST"
  force_new_deployment              = true
  tags                              = var.tags

  network_configuration {
    assign_public_ip = true
    subnets          = var.ecs_service_subnet_ids
    security_groups  = [aws_security_group.ecs_security_group.id]
  }
  load_balancer {
    target_group_arn = var.load_balancer_target_group_arn
    container_name   = "${var.project_name}-${var.app_env}-container"
    container_port   = var.application_port
  }
}
