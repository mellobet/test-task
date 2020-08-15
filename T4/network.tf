# Subnet
resource "aws_subnet" "test-task-subnet_1" {
  vpc_id     = aws_vpc.test-task-vpc.id
  cidr_block = var.cidr_subnet_1
  # Optionals
  map_public_ip_on_launch = true
}

resource "aws_subnet" "test-task-subnet_2" {
  vpc_id     = aws_vpc.test-task-vpc.id
  cidr_block = var.cidr_subnet_2
  # Optionals
  map_public_ip_on_launch = true
}

resource "aws_subnet" "test-task-subnet_3" {
  vpc_id     = aws_vpc.test-task-vpc.id
  cidr_block = var.cidr_subnet_3
  # Optionals
  map_public_ip_on_launch = true
}


# ADDITIONAL - Internet facing infra. #################
# It needs var "ssh_sg_port" value in "22"
resource "aws_internet_gateway" "test-task-igw" {
  vpc_id = aws_vpc.test-task-vpc.id
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.test-task-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-task-igw.id
  }
}

resource "aws_route_table_association" "rta-subnet_1" {
  subnet_id      = aws_subnet.test-task-subnet_1.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table_association" "rta-subnet_2" {
  subnet_id      = aws_subnet.test-task-subnet_2.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table_association" "rta-subnet_3" {
  subnet_id      = aws_subnet.test-task-subnet_3.id
  route_table_id = aws_route_table.rtb_public.id
}
########################################################