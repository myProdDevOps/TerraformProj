aws_config = {
  aws_region      = "us-east-1"
  aws_profile     = "default"
  aws_environment = "dev"
  aws_project     = "s3_cloudfront"
  aws_owner       = "mrtux"

}

bucket_config = {
  bucket_name      = "s3-cloudfront-terraform"
  is_force_destroy = true
  environment      = "dev"
}

default_root_object = "index.html"