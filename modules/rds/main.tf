data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "rds_sec_group" {
  vpc_id      = "${data.aws_vpc.default.id}"
  name        = "lanchonete_rds"
  description = "Allow all inbound for Postgres"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_db_parameter_group" "db_param_group" {
  name   = "${var.db_name}"
  family = "postgres15"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "lanchonete_db" {
  identifier             = "${var.db_name}"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "15.3"
  username               = "postgres"
  password               = "postgres"
  skip_final_snapshot    = true
  publicly_accessible    = true
  parameter_group_name   = aws_db_parameter_group.db_param_group.name
  vpc_security_group_ids = [aws_security_group.rds_sec_group.id]
}
