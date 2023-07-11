provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_vpc" "ljh_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "t101-study"
  }
}

resource "aws_subnet" "ljh_subnet1" {
  vpc_id     = aws_vpc.ljh_vpc.id
  cidr_block = "10.10.1.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "t101-subnet1"
  }
}

resource "aws_subnet" "ljh_subnet2" {
  vpc_id     = aws_vpc.ljh_vpc.id
  cidr_block = "10.10.2.0/24"

  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "t101-subnet2"
  }
}


resource "aws_internet_gateway" "ljh_igw" {
  vpc_id = aws_vpc.ljh_vpc.id

  tags = {
    Name = "t101-igw"
  }
}

resource "aws_route_table" "ljh_rt" {
  vpc_id = aws_vpc.ljh_vpc.id

  tags = {
    Name = "t101-rt"
  }
}

resource "aws_route_table_association" "ljh_rtassociation1" {
  subnet_id      = aws_subnet.ljh_subnet1.id
  route_table_id = aws_route_table.ljh_rt.id
}

resource "aws_route_table_association" "ljh_rtassociation2" {
  subnet_id      = aws_subnet.ljh_subnet2.id
  route_table_id = aws_route_table.ljh_rt.id
}

resource "aws_route" "mydefaultroute" {
  route_table_id         = aws_route_table.ljh_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ljh_igw.id
}

output "aws_vpc_id" {
  value = aws_vpc.ljh_vpc.id
}