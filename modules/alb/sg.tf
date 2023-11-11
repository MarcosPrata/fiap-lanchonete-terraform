resource "aws_security_group" "alb_security_group" {
  name   = "${var.project_name}-${var.app_env}-alb-security-group"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow all inbound traffic by default"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = "false"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound traffic by default"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}