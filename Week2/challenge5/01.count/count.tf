resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "pub_subnet" {
  count             = length(var.pub_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.pub_cidr, count.index)
  availability_zone = ((count.index) % 2) == 0 ? data.aws_availability_zones.az.names[0] : data.aws_availability_zones.az.names[2]

  tags = {
    Name = "${var.env}-pub-${((count.index) % 2) == 0 ? "a" : "c"}"
  }
}