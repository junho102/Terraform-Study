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