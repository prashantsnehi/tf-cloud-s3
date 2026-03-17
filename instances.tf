# locals {
#     instances_details = {
#         name              = "psnehi-instance"
#         ami               = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (HVM), SSD Volume Type
#         instance_type     = "t2.micro"
#         availability_zone = "ap-south-1a"
#     }
# }

resource "aws_instance" "myserver" {
  for_each = aws_subnet.subnets
  ami           = locals.instances_details.ami
  instance_type = locals.instances_details.instance_type
  availability_zone = locals.instances_details.availability_zone
  tags = {
    Name = locals.instances_details.name
  }
  #vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id                   = each.value.id
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
