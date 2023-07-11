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

resource "aws_instance" "httpd" {
  for_each      = var.project
  ami           = data.aws_ami.latest_ubuntu_2204.id
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.pub_subnet[each.value.public_subnet].id

  root_block_device {
    volume_size           = each.value.volume_size
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "${each.value.environment}-${each.key}"
  }
}