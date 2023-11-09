resource "aws_security_group" "lb_security_group" {
  description = "LoadBalancer Security Group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "sg_ingress_rule_all_to_lb" {
  type              = "ingress"
  description       = "Allow from anyone on port 8080"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.lb_security_group.id
}

resource "aws_security_group" "ecs_security_group" {
  description = "ECS Security Group"
  vpc_id      = var.vpc_id
  egress {
    description = "Allow all outbound traffic by default"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "sg_ingress_rule_ecs_cluster_from_lb" {
  type                     = "ingress"
  description              = "Ingress from Load Balancer"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_security_group.id
  source_security_group_id = aws_security_group.lb_security_group.id
}

resource "aws_security_group_rule" "sg_egress_rule_lb_to_ecs_cluster" {
  type                     = "egress"
  description              = "Target group egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.lb_security_group.id
  source_security_group_id = aws_security_group.ecs_security_group.id
}
