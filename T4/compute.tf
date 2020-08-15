resource "aws_instance" "instance_1" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.test-task-subnet_1.id
  vpc_security_group_ids = [aws_security_group.ssh.id]
  key_name               = aws_key_pair.ec2key.key_name
  user_data              = file("./user_data.sh")

  tags = {
    env = var.env_tag
  }
}

resource "aws_instance" "instance_2" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.test-task-subnet_2.id
  vpc_security_group_ids = [aws_security_group.ssh.id]
  key_name               = aws_key_pair.ec2key.key_name

  tags = {
    env = var.env_tag
  }
}

resource "aws_instance" "instance_3" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.test-task-subnet_3.id
  vpc_security_group_ids = [aws_security_group.ssh.id]
  key_name               = aws_key_pair.ec2key.key_name

  tags = {
    env = var.env_tag
  }
}

resource "aws_key_pair" "ec2key" {
  key_name   = "publicKey"
  public_key = file(var.public_key_path)
}
