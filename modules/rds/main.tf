resource "aws_db_parameter_group" "db_param_group" {
  name   = local.db_name
  family = "postgres15"
  tags   = var.tags

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "lanchonete_db" {
  identifier           = local.db_name
  instance_class       = "db.t3.micro"
  allocated_storage    = 5
  engine               = "postgres"
  engine_version       = "15.3"
  username             = "postgres"
  password             = "postgres"
  skip_final_snapshot  = true
  publicly_accessible  = false
  parameter_group_name = aws_db_parameter_group.db_param_group.name
  db_subnet_group_name = aws_db_subnet_group.aurora_subnet_group.name
  tags                 = var.tags
  vpc_security_group_ids = [
    aws_security_group.rds_sec_group.id,
    aws_security_group.ec2_security_group.id
  ]
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "tf-rds-${var.project_name}"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}
