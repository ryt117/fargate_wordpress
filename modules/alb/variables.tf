variable "vpc_id" {
  description = "The VPC ID for the ALB"
  type        = string
}

variable "public_subnet1_id" {
  description = "The Subnet ID for the EC2 instances"
  type        = string
}

variable "public_subnet2_id" {
  description = "The Subnet ID for the EC2 instances"
  type        = string
}

variable "instance1_id" {
  description = "The ID of the first EC2 instance"
  type        = string
}

variable "instance2_id" {
  description = "The ID of the second EC2 instance"
  type        = string
}
