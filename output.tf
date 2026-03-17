output "bucket_name" {
  value = aws_s3_bucket.demo-bucket.bucket
}

output "instance_id" {
  value = [for idx, instance in aws_instance.myserver : "${idx}-${instance.id}"]
}

output "instance_private_ip" {
  value = [for idx, instance in aws_instance.myserver : "${idx}-${instance.id}:-${instance.private_ip}"]
}

output "instance_public_ip" {
  value = [for idx, instance in aws_instance.myserver : "${idx}-${instance.id}:-${instance.public_ip}"]
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = [for idx, subnet in aws_subnet.subnets : "${idx}:-${subnet.id}"]
}
