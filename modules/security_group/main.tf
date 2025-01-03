resource "aws_security_group" "allow_ssh_icmp" {
  name        = "allow-ssh-icmp-http"
  description = "Allow SSH, ICMP, and HTTP traffic from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

   tags = {
    Environment = var.env_name
    Name        = "${var.resource_prefix}_Allow SSH, ICMP, and HTTP"
  }

}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.allow_ssh_icmp.id
}
