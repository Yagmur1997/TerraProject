variable "ami" {}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "var for instance type"
}
 
variable "key_pair" {}

variable "user_data" {
  type = string
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "security_groups"  {
  type = list(string) 
}

variable "region" {
  type        = string
  default     = "us-east-2"
  description = "aws env region"
}

variable "private_subnet_id" {
  type        = string
  description = "ID of the public subnet"
}