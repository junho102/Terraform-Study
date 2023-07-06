provider "aws" {
  region = "ap-northeast-2"
}

variable "name" {
  default = "ljh"
}

###### ami data ######
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

###### ec2 ######
resource "aws_instance" "apache" {
  ami                         = data.aws_ami.latest_ubuntu_22_04.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.apache_sg.id]

  user_data = filebase64("${path.module}/setup_apache.sh")

  tags = { Name = "${var.name}-apache-instance" }
}

###### security group ######
resource "aws_security_group" "apache_sg" {
  name = "${var.name}-sg"

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
