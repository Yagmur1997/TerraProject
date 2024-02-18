resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "new-vpc"
  }
}

resource "aws_subnet" "public-sub1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/26"
  availability_zone       = "${var.region}a"

  tags = {
    Name = "public subnet1"
  }
}

resource "aws_subnet" "public-sub2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.64/26"
  availability_zone       = "${var.region}b"

  tags = {
    Name = "public subnet2"
  }
}

resource "aws_subnet" "private-sub1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.128/26"
  availability_zone       = "${var.region}a"

  tags = {
    Name = "private subnet1"
  }
}

resource "aws_subnet" "private-sub2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.192/26"
  availability_zone       = "${var.region}b"

  tags = {
    Name = "private subnet2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "newIGT"
  }
}

resource "aws_route_table" "Pub-RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "Public RT"
  }
}

resource "aws_route_table_association" "RT-association1" {
  subnet_id = aws_subnet.public-sub1.id
  route_table_id = aws_route_table.Pub-RT.id
}

resource "aws_route_table_association" "RT-association2" {
  subnet_id = aws_subnet.public-sub2.id
  route_table_id = aws_route_table.Pub-RT.id
}

resource "aws_eip" "elastic_ip" {
  domain = "vpc"

  tags = {
    Name = "eip"
  }
}

resource "aws_nat_gateway" "NGT" {
  allocation_id     = aws_eip.elastic_ip.id
  connectivity_type = "public"
  subnet_id    = "${aws_subnet.public-sub1.id}"

  tags = {
    Name = "NATgt"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "Priv-RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NGT.id
  }
   tags = {
    Name = "private subnet RT"
   }
}

resource "aws_route_table_association" "RT-association3" {
  subnet_id      = aws_subnet.private-sub1.id
  route_table_id = aws_route_table.Priv-RT.id
}

resource "aws_route_table_association" "RT-association4" {
  subnet_id      = aws_subnet.private-sub2.id
  route_table_id = aws_route_table.Priv-RT.id
}

# resource "aws_db_subnet_group" "example_subnet_group" {
#   name       = "example-subnet-group"
#   subnet_ids = [aws_subnet.private_subnet.id, aws_subnet.private_subnet.id]
# }

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private-sub1.id, aws_subnet.private-sub2.id]
}
