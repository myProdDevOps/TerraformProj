// Init cloudfront instance
module "cloudfront" {
  source                = "./modules/cloudfront"
  s3_bucket_id          = module.s3.bucket_id
  s3_bucket_domain_name = module.s3.bucket_regional_domain_name
  default_root_object   = var.default_root_object
}

// Init s3 instance
module "s3" {
  source = "./modules/s3"
  cloudfront_distribution_arn = module.cloudfront.cloudfront_arn

  bucket_config = {
    bucket_name              = var.bucket_config.bucket_name
    is_force_destroy         = var.bucket_config.is_force_destroy
    environment              = var.bucket_config.environment
  }
  depends_on_list = [module.cloudfront.cloudfront_distribution_id]
}