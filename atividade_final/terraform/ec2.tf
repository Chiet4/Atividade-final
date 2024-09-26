resource "aws_instance" "todoList" {
  ami                    = "ami-0e86e20dae9224db8"
  instance_type          = "t2.micro"
  key_name               = "vockey"
  vpc_security_group_ids = [aws_security_group.todoList_gp.id]
  subnet_id              = aws_subnet.private_subnet_1.id
  associate_public_ip_address = true

  tags = {
    Name = "todoList"
    Dev  = "Anchieta Albano"
  }

}