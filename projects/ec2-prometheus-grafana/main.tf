terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.25.0"
    }
    rsa = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
  }
}


variable "region" {
  default = "eu-west-1"
}
variable "name_prefix" {
  description = "The tag of the project"
  default     = "devops-playground-ec2-lamp"
}


module "key_pair" {
  source        = "../../terraform/key_pair"
  key_pair_name = var.name_prefix
}

module "network" {
  source      = "../../terraform/network"
  region      = var.region
  name_prefix = var.name_prefix
}

module "ec2_security_group" {
  source      = "../../terraform/security_group"
  name_prefix = var.name_prefix
  vpc_id      = module.network.vpc_id
  ingress     = ["80", "22", "9090", "3000"]
}

module "ec2" {
  source          = "../../terraform/ec2"
  name_prefix     = var.name_prefix
  security_groups = [module.ec2_security_group.id]
  subnet_id       = module.network.subnet_id
  key_pair_name   = var.name_prefix
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}
