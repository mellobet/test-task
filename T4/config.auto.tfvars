# General
region        = "us-east-1"
cidr_vpc      = "10.1.0.0/16"
cidr_subnet_1 = "10.1.1.0/24"
cidr_subnet_2 = "10.1.2.0/24"
cidr_subnet_3 = "10.1.3.0/24"


# ECS2
instances_count = 3
instance_type   = "t2.small"
instance_ami    = "ami-07957d39ebba800d5"

# Env.
env_tag = "task"

# SGs
ssh_sg_port         = 2222
ssh_sg_ingress_cidr = "0.0.0.0/0"
