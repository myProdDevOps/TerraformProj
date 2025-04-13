output "cloudfront_distribution_id" {
  value = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_domain_name" {
  value = module.cloudfront.cloudfront_domain_name
}

output "s3_bucket_id" {
  value = module.s3.bucket_id
}

output "s3_bucket_domain_name" {
  value = module.s3.bucket_regional_domain_name
}