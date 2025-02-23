resource "aws_s3_bucket" "test" {
    bucket_prefix = "terraform-"
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
    object_ownership = "BucketOwnerEnforced"
  }
}

locals {
  s3_origin_id = "testS3Origin"
}