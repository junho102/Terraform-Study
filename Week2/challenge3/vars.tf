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
  description = "instance volume size"
  type        = list(string)
  default     = ["30", "40", "50"]
}

variable "instance_type" {
  default = "t2.micro"
}

variable "my_name" {
  type    = list(string)
  default = ["junho1", "junho2", "junho3"]
}

variable "port_num" {
  type    = list(string)
  default = ["7070", "8080", "9090"]
}