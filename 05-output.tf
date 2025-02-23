output "cloudfront_url" {
     description = "Cloudfront host URL (HTTP)"
    value = "https://${aws_cloudfront_distribution.CFtest.domain_name}"
    }