resource "aws_instance" "k3s_master" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_subnet1.id
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [aws_security_group.k3s_nodes_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              curl -sfL https://get.k3s.io | sh -
              EOF

  tags = {
    Name = "k3s-master"
  }
}

resource "aws_instance" "k3s_agent" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_subnet2.id
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [aws_security_group.k3s_nodes_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              curl -sfL https://get.k3s.io | K3S_URL="https://${aws_instance.k3s_master.private_ip}:6443" K3S_TOKEN="$(sudo cat /var/lib/rancher/k3s/server/node-token)" sh -
              EOF

  depends_on = [aws_instance.k3s_master]

  tags = {
    Name = "k3s-agent"
  }
}
