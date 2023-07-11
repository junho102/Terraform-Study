data "aws_ami" "latest_ubuntu_2204" {
  most_recent = true #최신 ami가져옴
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

variable "instance_num" {
  description = "number of busybox instance"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "instance_volume_size" {
  default = "30"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "my_name" {
  default = "junho"
}

variable "port_num" {
  default = "8080"
}

locals {
  inst_num         = var.instance_num
  inst_vol_size    = var.instance_volume_size
  inst_type        = var.instance_type
  ubuntu_22_04_ami = data.aws_ami.latest_ubuntu_2204.id

  custom_data_args = {
    my_name  = var.my_name
    port_num = var.port_num
  }
}