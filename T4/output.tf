output "public_dns_1" {
  value = aws_instance.instance_1.*.public_dns
}

output "public_dns_2" {
  value = aws_instance.instance_2.*.public_dns
}

output "public_dns_3" {
  value = aws_instance.instance_3.*.public_dns
}
