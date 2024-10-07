provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.r.id
}

resource "aws_security_group" "rancher_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "rancher" {
  ami             = "ami-09e67e426f25ce0d7"
  instance_type   = "t3.medium"
  subnet_id       = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.rancher_sg.id]
  tags = {
    Name = "rancher-server"
  }

  user_data = <<-EOF
              #!/bin/bash
              # Adicione os comandos de inicialização aqui
              EOF
}

resource "aws_instance" "k8s_nodes" {
  count           = 3
  ami             = "ami-09e67e426f25ce0d7"
  instance_type   = "t3.medium"
  subnet_id       = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.rancher_sg.id]
  tags = {
    Name = "rancher-k8s-${count.index + 1}"
  }

  user_data = <<-EOF
              #!/bin/bash
              # Adicione os comandos de inicialização aqui
              EOF
}

resource "aws_eip" "rancher_ip" {
  instance = aws_instance.rancher.id
}

resource "aws_route53_record" "rancher_dns" {
  zone_id = "YOUR_ROUTE53_ZONE_ID"
  name    = "rancher.admaioratecnologia.xyz"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.rancher_ip.public_ip]
}
