resource "aws_vpc" "test-vpc" {
  cidr_block = "10.20.0.0/16"
}

data "aws_availability_zones" "available" {
}

resource "aws_subnet" "private_subnet" {
  vpc_id = "${aws_vpc.test-vpc.id}"
  cidr_block = "10.20.30.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-west-1a"

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = "${aws_vpc.test-vpc.id}"
  cidr_block = "10.20.31.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-west-1a"

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = "${aws_vpc.test-vpc.id}"
  cidr_block = "10.20.32.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-west-1a"

  tags = {
    Name = "private_subnet"
  }
}
resource "aws_subnet" "public_subnet_1" {
  vpc_id = "${aws_vpc.test-vpc.id}"
  cidr_block = "10.20.33.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-west-1a"

  tags = {
    Name = "private_subnet"
  }
}

/*
resource "aws_internet_gateway" "test-igw" {
  vpc_id = aws_vpc.test-vpc.id
}


resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.test-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.test-igw.id
}


resource "aws_eip" "test-eip" {
  count      = var.az_ct
  vpc        = true
  depends_on = [aws_internet_gateway.test-igw]
}

resource "aws_nat_gateway" "test-ngw" {
  count         = var.az_ct
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.test-eip.*.id, count.index)
}

resource "aws_route_table" "private" {
  count  = var.az_ct
  vpc_id = aws_vpc.test-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.test-natgw.*.id, count.index)
  }
}

resource "aws_route_table_association" "private" {
  count          = var.az_ct
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
*/