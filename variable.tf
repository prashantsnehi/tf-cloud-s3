variable "AWS_SECRET_ACCESS_KEY" {
    type = string
    description = "AWS Secret Access Key"
    default = null
}

variable "AWS_ACCESS_KEY_ID" {
  type = string
  description = "AWS Secret Access Key ID"
  default = null
}

variable "AWS_REGION" {
  type = string
  description = "AWS Region"
  default = "ap-south-1"
}

variable "aws_instances_details" {
    type = object({
      name = string
      instance_type = string
      ami = string
      availability_zone = string
      subnet_id = string
    })

    default = {
      name = "psnehi-instance"
      instance_type = "t2.micro"
      ami = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (HVM), SSD Volume Type
      availability_zone = AWS_REGION 
      subnet_id = ""
    }
}