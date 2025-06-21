# Security Group for Bastion Host
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH from specific IP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "SSH from your IP"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

# EC2 Bastion Host in Public Subnet
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_subnet1.id
  key_name               = var.ssh_key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "bastion-host"
  }
}
