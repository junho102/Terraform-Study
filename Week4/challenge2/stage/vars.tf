variable "env" {
  description = "environment"
  default     = "dev"
}

### cidr valiable ###
#####################
variable "vpc_cidr" {
  description = "VPC CIDR BLOCK : x.x.x.x/x"
  default     = "192.168.0.0/16"
}

variable "pub_cidr" {
  description = "pub CIDR BLOCK : x.x.x.x/x"
  type        = list(string)
  default     = ["192.168.1.0/24", "192.168.2.0/24"]
}

variable "pri_cidr" {
  description = "pri CIDR BLOCK : x.x.x.x/x"
  type        = list(string)
  default     = ["192.168.3.0/24", "192.168.4.0/24"]
}

locals {
  env      = var.env
  vpc_cidr = var.vpc_cidr
  pub_cidr = var.pub_cidr
  pri_cidr = var.pri_cidr
}