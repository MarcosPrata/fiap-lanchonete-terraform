resource "aws_lb" "ecs_alb" {
  name                       = "${var.project_name}-${var.app_env}-lb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = [var.ecs_service_subnet_id]
  enable_deletion_protection = false
  enable_http2               = true
  idle_timeout               = 60
}

resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
    }
  }
}
