variable "vpc_id" {
  description = "The ID of the VPC where the Load Balancer will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the Load Balancer"
  type        = list(string)
}

variable "resource_prefix" {
  description = "Prefix for the resources"
  type        = string
}

variable "load_balancer_type" {
  description = "Type of Load Balancer: network or application"
  type        = string
}

variable "listener_port" {
  description = "Port for the Load Balancer listener"
  type        = number
}

variable "protocol" {
  description = "Protocol for the listener and target group (TCP, HTTP, HTTPS)"
  type        = string
}

variable "env_name" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "instance_ids" {
  description = "A map of instance IDs to be registered with the target group"
  type        = map(string)  # Change this to map instead of list
}


variable "target_port" {
  description = "The port to use for target group attachment"
  type        = number
}
