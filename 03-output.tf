output "s3_url" {
    description = "S3 host URL (HTTP)"
    value = "http://${aws_s3_bucket_website_configuration.test.website_endpoint}"
}