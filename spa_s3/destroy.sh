et -e

echo "🧼 Starting clean destroy..."

# Step 1: Delete CloudFront first (Prevent 403 on s3 bucket)
echo "🧨 Destroying CloudFront distribution..."
terraform destroy -target=aws_cloudfront_distribution.cloudfront_distribution -auto-approve

# Step 2: Wait for AWS delay
echo "⏳ Waiting 90s for CloudFront to finish deletion..."
sleep 90

# Bước 3: Destroy leftover
echo "🧹 Destroying all remaining resources..."
terraform destroy -auto-approve
