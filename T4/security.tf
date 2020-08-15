# Security Group
resource "aws_security_group" "ssh" {
  name   = "ssh"
  vpc_id = aws_vpc.test-task-vpc.id


  ingress {
    from_port   = var.ssh_sg_port
    to_port     = var.ssh_sg_port
    protocol    = "tcp"
    cidr_blocks = [var.ssh_sg_ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
