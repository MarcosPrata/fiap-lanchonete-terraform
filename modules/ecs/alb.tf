resource "aws_lb" "ecs_alb" {
  name               = "${var.project_name}-${var.app_env}-ecs-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.ecs_security_group.id]
  subnets            = var.load_balancer_subnet_ids
  tags               = var.tags
}

resource "aws_lb_target_group" "ecs_target_group" {
  name        = "${var.project_name}-${var.app_env}-ecs-target-group"
  port        = var.application_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = var.incomming_load_balancer_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
  }
}
