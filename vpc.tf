resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "subnets" {
  count      = 2
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.${count.index}.0/24"
  tags = {
    Name = "psnehi-subnet-${count.index}"
  }
  depends_on = [aws_vpc.main]
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}

resource "aws_route_table_association" "my-route-table-association" {
  count          = length(aws_subnet.subnets)
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.my-route-table.id
  depends_on     = [aws_subnet.subnets]
}

