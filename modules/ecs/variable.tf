variable "vpc_id" {
  description = "The VPC ID for the ECS"
  type        = string
}

variable "public_subnet1_id" {
  description = "The Subnet ID for the ECS"
  type = string
}

variable "public_subnet2_id" {
  description = "The Subnet ID for the ECS"
  type = string
}

variable "alb_tg" {
  description = "The Target Group for the ECS"
  type = string
}

variable "db_host" {
  description = "RDS hostname"
  type = string
}

variable "db_name" {
  description = "Database name"
  type = string
}

variable "db_user" {
  description = "Database username"
  type = string
}

variable "db_password" {
  description = "Database password"
  type = string
}