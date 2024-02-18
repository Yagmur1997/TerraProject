variable "region" {
  type        = string
  default     = "us-east-2"
  description = "aws env region"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/24"
}

