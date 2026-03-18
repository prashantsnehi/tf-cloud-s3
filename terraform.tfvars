aws_instances_details = {
  "ubuntu" = {
    name              = "psnehi-instance"
    instance_type     = "t2.micro"
    ami               = "ami-05d2d839d4f73aafb" # Amazon Linux 2 AMI (HVM), SSD Volume Type
    availability_zone = "${var.region}a"
    region            = "${var.region}"
  }
}

