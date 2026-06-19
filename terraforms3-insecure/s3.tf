resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "my-insecure-bucket-lankesh"
}

resource "aws_s3_bucket_public_access_block" "insecure" {
  bucket = aws_s3_bucket.insecure_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public" {
  bucket = aws_s3_bucket.insecure_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "PublicRead"
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.insecure_bucket.arn}/*"
    }]
  })
}
