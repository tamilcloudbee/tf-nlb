provider "aws" {
  region = "us-east-1"
}

module "vpc_a" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_cidr_1   = var.public_cidr_1
  public_cidr_2   = var.public_cidr_2
  private_cidr_1  = var.private_cidr_1
  private_cidr_2  = var.private_cidr_2
  env_name        = "dev_a"
  resource_prefix = var.resource_prefix

}


/*

# Security Group Module
module "sg_a" {
  source   = "./modules/security_group"
  vpc_id   = module.vpc_a.vpc_id
}


# EC2 Instances in VPC A
module "ec2_a" {
  source              = "./modules/ec2"
  instance_type       = "t2.micro"
  public_subnet_id    = module.vpc_a.public_subnet_id
  private_subnet_id   = module.vpc_a.private_subnet_id
  key_name            = var.key_name
  env_name            = "dev_a"
  security_group_id   = module.sg_a.security_group_id
}


# EC2 Instances in VPC B
module "ec2_b" {
  source              = "./modules/ec2"
  instance_type       = "t2.micro"
  public_subnet_id    = module.vpc_b.public_subnet_id
  private_subnet_id   = module.vpc_b.private_subnet_id
  key_name            = var.key_name
  env_name            = "dev_b"
  security_group_id   = module.sg_b.security_group_id
}

*/