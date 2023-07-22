resource "aws_instance" "apache" {
  ami                    = data.aws_ami.latest_amazon_linux_2.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.apache_sg.id]
  key_name               = var.key_pair_name

  tags = { Name = "${var.name}-apache-instance" }
}

resource "null_resource" "file" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/test.pem")
    host        = aws_instance.apache.public_ip
  }

  provisioner "file" {
    source      = "setup_apache.sh"
    destination = "setup_apache.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x setup_apache.sh",
      "./setup_apache.sh"
    ]
  }
}