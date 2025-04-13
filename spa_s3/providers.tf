// Provider Identification and default Configuration
provider "aws" {
  region  = var.aws_config.aws_region
  profile = var.aws_config.aws_profile

  default_tags {
    tags = {
      "Terraform"   = "true"
      "Environment" = var.aws_config.aws_environment
      "Project"     = var.aws_config.aws_project
      "Owner"       = var.aws_config.aws_owner
    }
  }
}
