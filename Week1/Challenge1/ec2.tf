provider "aws" {
  region = "ap-northeast-2"
}

variable "name" {
  default = "ljh"
}

data "aws_ami" "latest_ubuntu_22_04" {
  most_recent = true # 최신 ami가져옴
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical (우분투를 만든회사에 대해서만 ami가져옴)
}

resource "aws_instance" "apache" {
  ami                         = data.aws_ami.latest_ubuntu_22_04.id
  instance_type               = "t2.micro"
  # associate_public_ip_address = true
  # subnet_id                   = aws_subnet.pub_subnet.id
  vpc_security_group_ids      = [aws_security_group.apache_sg.id]

  user_data = filebase64("${path.module}/setup_apache.sh")
  key_name  = "jh-testkey"

  tags = { Name = "${var.name}-apache-instance" }
}

resource "aws_security_group" "apache_sg" {
  name = "${var.name}-sg"

  # vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-sg"
  }
}
