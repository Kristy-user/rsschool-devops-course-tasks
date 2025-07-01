# K3s Master Node
resource "aws_instance" "k3s_master" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.private_subnet1.id
  vpc_security_group_ids      = [aws_security_group.k3s_nodes_sg.id]
  key_name                    = var.ssh_key_name
  associate_public_ip_address = false

  user_data = <<-EOF
    #!/bin/bash
    curl -sfL https://get.k3s.io | sh -
  EOF

  tags = {
    Name = "k3s-master"
  }
}

# Agent Node (joins master)
resource "aws_instance" "k3s_agent" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.private_subnet2.id
  vpc_security_group_ids      = [aws_security_group.k3s_nodes_sg.id]
  key_name                    = var.ssh_key_name
  associate_public_ip_address = false

  user_data = <<-EOF
    #!/bin/bash
    # Placeholder: see README for join instructions
  EOF

  tags = {
    Name = "k3s-agent"
  }
}
