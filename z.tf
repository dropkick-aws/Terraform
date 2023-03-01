// Define the AWS provider
provider "aws" {
  region = var.region
}

// Define the S3 bucket resource
resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

// Define the IAM user resource
resource "aws_iam_user" "example_user" {
  name = var.user_name
}

// Assign the user to the bucket
resource "aws_s3_bucket_policy" "example_policy" {
  bucket = aws_s3_bucket.example_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          AWS = aws_iam_user.example_user.arn
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "${aws_s3_bucket.example_bucket.arn}/*"
      }
    ]
  })
}

