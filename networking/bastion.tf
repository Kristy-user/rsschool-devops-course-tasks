resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet1.id
  key_name                    = var.ssh_key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "bastion-host"
  }
}

