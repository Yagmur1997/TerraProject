variable "region" {
  type        = string
  default     = "us-east-2"
  description = "var for region"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "var for instance type"
}

# variable "availability_zone" {
#   type        = string
#   default     = "us-east-2a"
#   description = "var for availability zone"

# }

variable "public_subnet_id" {
  type        = string
  description = "ID of the public subnet"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}


variable "aws_iam_instance_profile" {
  type = string
} 
variable "user_data" {
  type = string
}