variable "bucket_config" {
  description = "The configuration of the S3 bucket"
  type = object({
    bucket_name      = string
    is_force_destroy = bool
    environment      = string
  })
}

variable "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution"
  type        = string
}

variable "depends_on_list"{
  description = "List of resources to depend on"
  type = list(string)
}