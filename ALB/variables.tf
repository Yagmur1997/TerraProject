variable "security_groups" {
  type    = string
}

variable "public_subnet1" {
  type = string
  description = "ID of the public subnet"
}

variable "public_subnet2" {
  type = string
  description = "ID of the public subnet"
}

variable "vpc_id" {
  type = string
  description = "ID of the VPC"
}

variable "autoscaling_group_name" {
  type = string
  description = "Name of the autoscaling group"
}