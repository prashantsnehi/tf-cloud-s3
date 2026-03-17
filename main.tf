terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "random_id" "rand_id" {
  byte_length = 12
}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "tf-cloud-${random_id.rand_id.hex}"
}

resource "aws_security_group" "main" {
  name = "my-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

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
}

resource "aws_instance" "myserver" {
  ami           = "ami-07c8c1b18ca66bb07"
  instance_type = "t3.micro"
  #vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id                   = aws_subnet.subnets[0].id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.main.id]
  depends_on                  = [aws_security_group.main]

  lifecycle {
    #create_before_destroy = true
    #prevent_destroy = true
    #replace_triggered_by = [aws_security_group.main, aws_security_group.main.ingress]

    precondition {
      condition     = aws_security_group.main.id != ""
      error_message = "Security Group ID must not be blank"
    }

    postcondition {
      condition     = self.public_ip != ""
      error_message = "Public IP is not present."
    }
  }
}



  
