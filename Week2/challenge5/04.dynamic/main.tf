resource "aws_security_group" "bastion_sg" {
  name        = "allow_tls"
  description = "Bastion Allow inbound traffic"
  dynamic "ingress" {
    for_each = [80, 443, 22]
    iterator = port
    content {
      description = "bastion_allow_inbound"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}