variable "aws_config" {
  type = object({
    aws_region      = string
    aws_profile     = string
    aws_environment = string
    aws_project     = string
    aws_owner       = string
  })
}

variable "bucket_config" {
  type = object({
    bucket_name              = string
    is_force_destroy         = bool
    environment              = string
  })
}

variable "default_root_object" {
  description = "The default root object for the CloudFront distribution"
  type        = string
}