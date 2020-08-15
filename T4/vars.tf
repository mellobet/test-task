variable "region" {}
variable "cidr_vpc" {}
variable "instances_count" {}
variable "instance_type" {}
variable "instance_ami" {}
variable "env_tag" {}
variable "cidr_subnet_1" {}
variable "cidr_subnet_2" {}
variable "cidr_subnet_3" {}
variable "ssh_sg_port" {}
variable "ssh_sg_ingress_cidr" {}

# It ships the current user key.
variable "public_key_path" {
  description = "Public key path"
  default     = "~/.ssh/id_rsa.pub"
}
