et -e

echo "🔄 Initializing Terraform..."
terraform init -upgrade

echo "🚀 Applying infrastructure..."
terraform apply -auto-approve
