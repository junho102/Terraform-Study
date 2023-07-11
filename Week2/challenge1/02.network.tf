resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "pub_subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pub_cidr[0]
  availability_zone = data.aws_availability_zones.az.names[0]
  tags = {
    Name = "${var.env}-pub-${data.aws_availability_zones.az.names[0]}"
  }
}

resource "aws_subnet" "pub_subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pub_cidr[1]
  availability_zone = data.aws_availability_zones.az.names[2]
  tags = {
    Name = "${var.env}-pub-${data.aws_availability_zones.az.names[2]}"
  }
}