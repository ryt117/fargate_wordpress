resource "aws_db_instance" "db" {
  allocated_storage = 10
  db_name =  "wordpress"
  engine  = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  username       = "admin"
  password       = "Password123"
  backup_retention_period = "0"
  final_snapshot_identifier = true # 最終スナップショットのスキップ
  db_subnet_group_name    = aws_db_subnet_group.db_group.name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
}

resource "aws_db_subnet_group" "db_group" {
  name = "main"
  subnet_ids = [var.private_subnet1_id, var.private_subnet2_id]

  tags = {
    Name = "My DB Subnet group"
  }
}

resource "aws_security_group" "db_sg" {
  name = "rds-sg"
  description = "Allow db"
  vpc_id = var.vpc_id

  ingress {
    from_port = "3306"
    to_port = "3306"
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}