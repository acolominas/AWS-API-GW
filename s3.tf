resource "aws_s3_bucket" "images-bucket" {
  bucket = "image-manager-storage"
  acl    = "public-read"
}
