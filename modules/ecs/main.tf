resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project_name}-${var.app_env}-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "ecs_service" {
  name             = "${var.project_name}-${var.app_env}-service"
  cluster          = aws_ecs_cluster.ecs_cluster.id
  task_definition  = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"
  depends_on       = [aws_lb_target_group.alb_ecs_tg, aws_lb_listener.ecs_alb_listener]

  load_balancer {
    target_group_arn = aws_lb_target_group.alb_ecs_tg.arn
    container_name   = "lanchonete"
    container_port   = 8080
  }

  network_configuration {
    security_groups = [aws_security_group.ecs_security_group.id]
    subnets         = var.subnet_ids
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "lanchonete"
      image     = "nginx"
      essential = true
      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        }
      ]
    }
  ])
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.ecs_task_exec_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
}
