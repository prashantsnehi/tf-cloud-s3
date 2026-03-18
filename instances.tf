resource "aws_instance" "myserver" {
  # for_each = {
  #   for idx, subnet in aws_subnet.subnets : subnet.id => subnet
  # }
  count = length(aws_subnet.subnets)

  ami               = var.aws_instances_details["ubuntu"].ami
  instance_type     = var.aws_instances_details["ubuntu"].instance_type
  region = var.AWS_REGION
  availability_zone = var.aws_instances_details["ubuntu"].availability_zone
  tags = {
    Name = "${var.aws_instances_details["ubuntu"].name}-${count.index + 1}"
  }
  #vpc_security_group_ids = [aws_security_group.main.id]
  # subnet_id                   = each.value.id
  subnet_id = aws_subnet.subnets[count.index].id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.main.id]
  depends_on                  = [aws_security_group.main]

  lifecycle {
    #create_before_destroy = true
    prevent_destroy = true
    #replace_triggered_by = [aws_security_group.main, aws_security_group.main.ingress]

    # precondition {
    #   condition     = aws_security_group.main.id != ""
    #   error_message = "Security Group ID must not be blank"
    # }

    # postcondition {
    #   condition     = self.public_ip != ""
    #   error_message = "Public IP is not present."
    # }
  }
}
