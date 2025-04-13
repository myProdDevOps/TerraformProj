output "cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.cloudfront_distribution.id
  description = "The ID of the CloudFront distribution."
}

output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.cloudfront_distribution.domain_name
  description = "The domain name of the CloudFront distribution."
}

output "cloudfront_arn" {
  value       = aws_cloudfront_distribution.cloudfront_distribution.arn
  description = "The ARN of the CloudFront distribution."
}

output "cloudfront_origin_access_control_id" {
  value       = aws_cloudfront_origin_access_control.oac.id
  description = "The ID of the CloudFront origin access control."
}