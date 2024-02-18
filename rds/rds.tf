resource "aws_db_instance" "rds_instance" {
  identifier             = "rds-ec2"
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  username               = "aidana"
  password               = "project123"
  db_subnet_group_name   = var.subnet_groups
  vpc_security_group_ids = [var.security_groups]
  publicly_accessible    = false
  skip_final_snapshot    = true
}

