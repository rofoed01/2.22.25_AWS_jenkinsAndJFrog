resource "aws_s3_bucket" "test" {
    bucket_prefix = "2.2.25_terraform-"
    object_lock_enabled = false
    force_destroy = true
    
    tags = {
        name = "my bucket"
        environment = "dev"
    }
}

resource "aws_s3_bucket" "state" {
  bucket_prefix = "2.2.25_tfState-"
  object_lock_enabled = false
  force_destroy = true

  tags = {
    name = "my bucket"
    environment = "dev"
  } 
}

resource "aws_s3_bucket_ownership_controls" "test" {
  bucket = aws_s3_bucket.test.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "test" {
  bucket = aws_s3_bucket.test.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "test" {
  depends_on = [
    aws_s3_bucket_ownership_controls.test,
    aws_s3_bucket_public_access_block.test,
  ]

  bucket = aws_s3_bucket.test.id
  acl    = "public-read"
   
}

resource "aws_s3_bucket_website_configuration" "test" {
  bucket = aws_s3_bucket.test.id

  index_document {
    suffix = "index.html"
  }
}
