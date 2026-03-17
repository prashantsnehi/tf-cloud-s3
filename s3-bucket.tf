resource "aws_s3_bucket" "demo-bucket" {
  bucket = "tf-cloud-${random_id.rand_id.hex}"
}