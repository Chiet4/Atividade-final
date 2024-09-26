

resource "aws_db_instance" "RDS" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "16"
  instance_class       = "db.t3.micro"
  username             = "postgre"
  password             = "16senha55servicos"
  parameter_group_name = aws_db_parameter_group.custom_postgres.name
  skip_final_snapshot  = true
  publicly_accessible  = false

  vpc_security_group_ids = [aws_security_group.todoList_gp.id]
  db_subnet_group_name   = aws_db_subnet_group.todolist_db_subnet_group.name

  identifier            = "todolist-db-instance" 
  
}


resource "aws_db_parameter_group" "custom_postgres" {
  name        = "custom-postgres"
  family      = "postgres16"
  description = "Custom parameter group for PostgreSQL 16"

  parameter {
    name         = "max_connections"
    value        = "100"
    apply_method = "pending-reboot"
  }
}