resource "aws_launch_template" "launch_template" {
  name     = "asg-ec2-template"

  image_id = var.ami

  instance_type = var.instance_type

  key_name = var.key_pair

  user_data = var.user_data

  network_interfaces {
    associate_public_ip_address = true
    device_index    = 0
    subnet_id      = var.private_subnet_id
    security_groups = var.security_groups
  }

  lifecycle {
    create_before_destroy = true
  }
}
