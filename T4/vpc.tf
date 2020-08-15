resource "aws_vpc" "test-task-vpc" {
  cidr_block = var.cidr_vpc

  # Optionals
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "test-task-vpc"
  }
}
