variable "s3_bucket_domain_name" {
  description = "S3 bucket regional domain name"
  type        = string
}

variable "s3_bucket_id" {
  description = "S3 bucket id"
  type        = string
}

variable "default_root_object" {
  description = "Default root object for CloudFront"
  type        = string
}
