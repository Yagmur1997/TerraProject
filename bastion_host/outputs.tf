output "key_pair" {
    value = aws_key_pair.key_pair.key_name
}

output "ami" {
    value = data.aws_ami.name.id
}