output "security_groups" {
  value = aws_security_group.asg_security_group.id
  description = "value"
}
