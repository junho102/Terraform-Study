data "aws_availability_zones" "az" {
  state = "available"
}

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

variable "env" {
  description = "environment"
  default     = "test"
}

variable "vpc_cidr" {
  description = "VPC CIDR BLOCK : x.x.x.x/x"
  default     = "192.168.0.0/16"
}

variable "pub_cidr" {
  description = "pub CIDR BLOCK : x.x.x.x/x"
  type        = list(string)
  default     = ["192.168.1.0/24", "192.168.2.0/24"]
}

variable "project" {
  description = "Map of project names to configuration."
  type        = map(any)

  default = {
    client-webapp = {
      instance_type          = "t2.micro",
      environment            = "dev"
      volume_size            = "30"
      aws_availability_zones = "0"
      public_subnet          = "0"
    },
    internal-webapp = {
      instance_type          = "t2.nano",
      environment            = "test"
      volume_size            = "50"
      aws_availability_zones = "2"
      public_subnet          = "1"
    }
  }
}