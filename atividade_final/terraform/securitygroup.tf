resource "aws_security_group" "todoList_gp" {
  name        = "todoList security group"
  vpc_id      = aws_vpc.main.id
  description = "Grupo de Seguranca para App TodoList"

  tags = {
    Name = "Group TodoList"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_Ipv4" {
  security_group_id = aws_security_group.todoList_gp.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "http_80" {
  security_group_id = aws_security_group.todoList_gp.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "permitir_trafego_de_saida" {
  security_group_id = aws_security_group.todoList_gp.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group_rule" "allow_ec2_access_rds" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.todoList_gp.id
  source_security_group_id = aws_security_group.todoList_gp.id
}


resource "aws_db_subnet_group" "todolist_db_subnet_group" {
  name       = "todolist-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "Todolist DB Subnet Group"
  }
}
