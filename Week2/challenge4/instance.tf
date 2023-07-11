provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "httpd" {
  ami           = local.ubuntu_22_04_ami
  instance_type = local.inst_type

  user_data = base64encode(templatefile("${path.module}/init_busybox.tpl", local.custom_data_args))

  root_block_device {
    volume_size           = local.inst_vol_size
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [user_data]
  }

  tags = {
    Name = "${local.custom_data_args.my_name}-instance"
  }
}

output "public_ip" {
  value = "curl ${aws_instance.httpd.public_ip}:${local.custom_data_args.port_num}"
}