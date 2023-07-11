output "instance1_public_ip" {
  value = "curl ${aws_instance.httpd[0].public_ip}:${var.port_num[0]}"
}
output "instance2_public_ip" {
  value = "curl ${aws_instance.httpd[1].public_ip}:${var.port_num[1]}"
}
output "instance3_public_ip" {
  value = "curl ${aws_instance.httpd[2].public_ip}:${var.port_num[2]}"
}