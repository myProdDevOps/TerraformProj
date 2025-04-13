data "aws_caller_identity" "current" {}
// Init bucket
resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_config.bucket_name
  force_destroy = var.bucket_config.is_force_destroy

  tags = {
    Name        = var.bucket_config.bucket_name
    Environment = var.bucket_config.environment
  }
}

// Set bucket policy to allow CloudFront to access the S3 bucket
resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "AllowGetObject",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.bucket.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = var.cloudfront_distribution_arn # ARN from CloudFront
          }
        }
      },
      {
        Sid       = "DenyPublicReadAccess",
        Effect    = "Deny",
        Principal = "*",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.bucket.arn,
          "${aws_s3_bucket.bucket.arn}/*"
        ],
        Condition = {
          StringNotEqualsIfExists = {
            "aws:PrincipalServiceName" = "cloudfront.amazonaws.com",
            "aws:PrincipalArn"         = data.aws_caller_identity.current.arn
          }
        }
      }
    ]
  })
}

// Upload SPA to S3 by corresponding folder
locals {
  build_dir = "${path.module}/../../static/testing-react-apps/build"

  // Mapping: extension → { content_type, cache_control }
  file_metadata = {
    ".html" = { content_type = "text/html", cache_control = "no-cache" }
    ".css" = { content_type = "text/css", cache_control = "max-age=31536000" }
    ".js" = { content_type = "application/javascript", cache_control = "max-age=31536000" }
    ".png" = { content_type = "image/png", cache_control = "max-age=31536000" }
    ".jpg" = { content_type = "image/jpeg", cache_control = "max-age=31536000" }
    ".jpeg" = { content_type = "image/jpeg", cache_control = "max-age=31536000" }
    ".svg" = { content_type = "image/svg+xml", cache_control = "max-age=31536000" }
    ".json" = { content_type = "application/json", cache_control = "no-cache" }
    ".ico" = { content_type = "image/x-icon", cache_control = "max-age=31536000" }
    ".txt" = { content_type = "text/plain", cache_control = "max-age=31536000" }
    ".pdf" = { content_type = "application/pdf", cache_control = "max-age=31536000" }
  }
}

resource "aws_s3_object" "website_files" {
  for_each = fileset(local.build_dir, "**/*")

  bucket = aws_s3_bucket.bucket.id
  key    = each.value
  source = "${local.build_dir}/${each.value}"
  etag = filemd5("${local.build_dir}/${each.value}")

  // Get .ext of file via lookup
  content_type = lookup(
    local.file_metadata,
    lower(try(regex("\\.[^.]+$", each.value), "")),
    { content_type = "application/octet-stream" }
  ).content_type

  cache_control = lookup(
    local.file_metadata,
    lower(try(regex("\\.[^.]+$", each.value), "")),
    { cache_control = "max-age=31536000" }
  ).cache_control
}