provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "ec2" {
  count         = length(var.instance_num)
  ami           = data.aws_ami.latest_ubuntu_2204.id
  instance_type = var.instance_type

  root_block_device {
    volume_size           = var.instance_volume_size[count.index]
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "instance-${count.index + 1}"
  }
}

output "public_ip_test1" {
  value = [for t in aws_instance.ec2.*.public_ip : "${t}"]
}

output "public_ip_test2" {
  value = [for t in aws_instance.ec2 : "${t.tags.Name} public_ip = ${t.public_ip}"]
}