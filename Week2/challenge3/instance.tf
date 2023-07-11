provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "httpd" {
  count         = length(var.instance_num)
  ami           = data.aws_ami.latest_ubuntu_2204.id
  instance_type = var.instance_type

  user_data = base64encode(templatefile("${path.module}/init_busybox.tpl", merge({ my_name = var.my_name[count.index] }, { port_num = var.port_num[count.index] })))

  root_block_device {
    volume_size           = var.instance_volume_size[count.index]
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [user_data]
  }

  tags = {
    Name = "instance-${count.index + 1}"
  }
}