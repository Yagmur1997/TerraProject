output "public_subnet1" {
  value = aws_subnet.public-sub1.id
description = "value"
}

output "public_subnet2" {
  value = aws_subnet.public-sub2.id
description = "value"
}

output "main_vpc" {
  value = aws_vpc.vpc.id
  description = "value"
}

output "private_subnet1" {
  value = aws_subnet.private-sub1.id
  description = "value"
}


output "private_subnet2" {
  value = aws_subnet.private-sub2.id
  description = "value"
}

output "subnet_groups" {
    value = aws_db_subnet_group.db_subnet_group.id
}
