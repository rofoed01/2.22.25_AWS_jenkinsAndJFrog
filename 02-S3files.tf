resource "aws_s3_object" "upload_images_png" {
  for_each     = fileset("${path.module}/", "*.png")
  bucket       = aws_s3_bucket.test.id
  key          = each.value
  acl          = "public-read"
  source       = "${path.module}/${each.value}"
  etag         = filemd5("${path.module}/${each.value}")
  content_type = "image/png"
}

resource "aws_s3_object" "upload_images_jpeg" {
  for_each     = fileset("${path.module}/", "*.jpg")
  bucket       = aws_s3_bucket.test.id
  key          = each.value
  acl          = "public-read"
  source       = "${path.module}/${each.value}"
  etag         = filemd5("${path.module}/${each.value}")
  content_type = "image/jpeg"
}

resource "aws_s3_object" "upload_html" {
  for_each     = fileset("${path.module}/", "*.html")
  bucket       = aws_s3_bucket.test.id
  key          = each.value
  acl          = "public-read"
  source       = "${path.module}/${each.value}"
  etag         = filemd5("${path.module}/${each.value}")
  content_type = "text/html"
}

resource "aws_s3_object" "upload_audio" {
  for_each     = fileset("${path.module}/", "*.mp3")
  bucket       = aws_s3_bucket.test.id
  key          = each.value
  acl          = "public-read"
  source       = "${path.module}/${each.value}"
  etag         = filemd5("${path.module}/${each.value}")
  content_type = "audio/mpeg"
}