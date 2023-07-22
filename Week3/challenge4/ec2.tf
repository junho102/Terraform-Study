resource "aws_network_interface" "ec2_private_ip" {
  subnet_id       = aws_subnet.pub_subnet.id
  private_ips     = ["192.168.1.11"]
  security_groups = [aws_security_group.apache_instance_sg.id]
  tags = {
    Name = "private_network_interface"
  }
}

resource "aws_eip" "apache_ec2_eip" {
  domain = "vpc"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.latest_amazon_linux_2.id
  instance_type = "t2.micro"
  key_name      = var.key_pair_name

  network_interface {
    network_interface_id = aws_network_interface.ec2_private_ip.id
    device_index         = 0
  }

  tags = { Name = "${var.env}-instance" }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.apache_ec2_eip.id
}

resource "terraform_data" "ec2_trigger" {
  triggers_replace = [aws_instance.web.private_ip]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${path.module}/test.pem")
      host        = aws_eip.apache_ec2_eip.public_ip
    }
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd"
    ]
    
  }

  depends_on = [aws_eip_association.eip_assoc, aws_instance.web]
}