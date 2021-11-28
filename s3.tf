resource "aws_s3_bucket" "images-bucket" {
  bucket = "image-manager-storage"
}

resource "aws_s3_bucket_policy" "prod_website" {
  bucket = aws_s3_bucket.images-bucket.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": [
             "s3:GetObject"
          ],
          "Resource": [
             "arn:aws:s3:::${aws_s3_bucket.images-bucket.id}/*"
          ]
      }
    ]
}
EOF
}
