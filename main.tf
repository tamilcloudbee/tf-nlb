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

module "lb_a" {
  source             = "./modules/lb"
  vpc_id             = module.vpc_a.vpc_id
  public_subnet_ids  = [module.vpc_a.public_subnet_1_id, module.vpc_a.public_subnet_2_id]
  resource_prefix    = var.resource_prefix
  load_balancer_type = "network"  # Use "application" for ALB
  listener_port      = 80
  protocol           = "TCP"  # Use "HTTP" or "HTTPS" for ALB
  target_port        = 80
  instance_ids = {
    "ec2_a" = module.ec2_a.public_instance_id
    "ec2_b" = module.ec2_b.public_instance_id
  }
}







# Security Group Module
module "sg_a" {
  source   = "./modules/security_group"
  vpc_id   = module.vpc_a.vpc_id
  env_name        = "dev_a"
  resource_prefix = var.resource_prefix

}


# EC2 Instances in VPC A
module "ec2_a" {
  source              = "./modules/ec2"
  instance_type       = "t2.micro"
  public_subnet_id    = module.vpc_a.public_subnet_1_id
  # private_subnet_id   = module.vpc_a.private_subnet_id
  user_data           = file("user_data.sh")  # Use file() directly here
  key_name            = var.key_name
  env_name            = "dev_a"
  security_group_id   = module.sg_a.security_group_id
  resource_prefix = var.resource_prefix

}

# EC2 Instances in VPC A
module "ec2_b" {
  source              = "./modules/ec2"
  instance_type       = "t2.micro"
  public_subnet_id    = module.vpc_a.public_subnet_2_id
  # private_subnet_id   = module.vpc_a.private_subnet_id
  user_data           = file("user_data.sh")  # Use file() directly here  
  key_name            = var.key_name
  env_name            = "dev_a"
  security_group_id   = module.sg_a.security_group_id
  resource_prefix = var.resource_prefix

}

