# Internet GW
resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id
  tags = {
    Name = "${local.env}-igw"
  }
}

# NAT GW EIP
resource "aws_eip" "natgw_ip" {
  domain = "vpc"
}

# NAT GW
resource "aws_nat_gateway" "natgw_az1" {
  allocation_id = aws_eip.natgw_ip.id
  subnet_id     = local.pub_subnet[0].id

  tags = {
    Name = "${local.env}-natgw"
  }

  depends_on = [aws_internet_gateway.igw]
}