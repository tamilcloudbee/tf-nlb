# Data block to fetch the latest Ubuntu AMI ID in the region
data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Ubuntu official owner ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# EC2 Instance in the Public Subnet
resource "aws_instance" "public_instance" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  key_name      = var.key_name
  associate_public_ip_address = true
  security_groups = [var.security_group_id]

  tags = {
    Name        = "${var.env_name}-Public-Instance"
    Environment = var.env_name
  }
}

# EC2 Instance in the Private Subnet
resource "aws_instance" "private_instance" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  key_name      = var.key_name
  associate_public_ip_address = false
  security_groups = [var.security_group_id]

  tags = {
    Name        = "${var.env_name}-Private-Instance"
    Environment = var.env_name
  }
}

output "public_instance_id" {
  description = "The ID of the public EC2 instance"
  value       = aws_instance.public_instance.id
}

output "private_instance_id" {
  description = "The ID of the private EC2 instance"
  value       = aws_instance.private_instance.id
}
