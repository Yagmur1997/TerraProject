data "aws_ami" "name" {
  most_recent = true

  owners = ["137112412989"] # Canonical

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20240124.0-x86_64-gp2"]
  }
}

resource "aws_key_pair" "key_pair" {
  key_name   = "new_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "SG" {
  name        = "SGforBH"
  description = "SG for BastionHost"
  vpc_id      = var.vpc_id
  tags        = local.tags
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1" # -1 special value indicating that all protocols are allowed.
    to_port     = 0
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1" # -1 special value indicating that all protocols are allowed.
    to_port     = 0
  }
}

resource "aws_instance" "bastionhost" {
  ami                         = data.aws_ami.name.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key_pair.key_name
  security_groups             = [aws_security_group.SG.id]
  availability_zone           = "${var.region}a"
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  user_data = var.user_data

  iam_instance_profile = var.aws_iam_instance_profile

  
  tags = {
    Name = "BastionHost"
  }
}