output "bucket_name" {
  value = aws_s3_bucket.demo-bucket.bucket
}

output "instance_id" {
  value = aws_instance.myserver.id
}

output "instance_private_ip" {
  value = aws_instance.myserver.private_ip
}

output "instance_public_ip" {
  value = aws_instance.myserver.public_ip
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = [for idx,subnet in aws_subnet.subnets : "${idx}:-${subnet.id}" ]
}