provider "aws" {
  region  = "ap-northeast-2"
}

variable "name" {
  default = "ljh"
}

###### VPC #######
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}

###### Subnet #######
resource "aws_subnet" "pub_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "${var.name}-subnet"
  }
}

###### Internet Gateway #######
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.name}-igw"
  }
}

####### routing table #######
resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "${var.name}-rt" }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_asso_rt" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.route_table_public.id
}
