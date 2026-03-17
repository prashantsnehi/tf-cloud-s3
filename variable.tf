variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = "AWS Secret Access Key"
  default     = null
}

variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = "AWS Secret Access Key ID"
  default     = null
}

variable "AWS_REGION" {
  type        = string
  description = "AWS Region"
  default     = "ap-south-1"
}
variable "aws_instances_details" {
  type = map(object({
    name              = string
    instance_type     = string
    ami               = string
    availability_zone = string
  }))
}
