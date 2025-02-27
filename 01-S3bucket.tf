resource "aws_s3_bucket" "test" {
    bucket_prefix = "terraform-s3-"
    object_lock_enabled = false
    force_destroy = true
    
    tags = {
        name = "my bucket"
        environment = "dev"
    }
}
resource "aws_s3_bucket_acl" "test" {
  depends_on = [aws_s3_bucket_ownership_controls.test, 
                aws_s3_bucket_public_access_block.test]

  bucket = aws_s3_bucket.test.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "test" {
  bucket = aws_s3_bucket.test.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "test" {
  bucket = aws_s3_bucket.test.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

locals {
  s3_origin_id = "testS3Origin"
}