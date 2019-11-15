# KMS
output "aws_kms_key_arn" {
  value = aws_kms_key.vault.arn
}

output "aws_kms_key_id" {
  value = aws_kms_key.vault.key_id
}

# S3
output "aws_s3_bucket_arn" {
  value = aws_s3_bucket.vault.arn
}

output "aws_s3_bucket_domain_name" {
  value = aws_s3_bucket.vault.bucket_domain_name
}

output "aws_s3_bucket_id" {
  value = aws_s3_bucket.vault.id
}

output "aws_s3_bucket_region" {
  value = aws_s3_bucket.vault.region
}

# Worker
output "worker_iam_role_arn" {
  value = data.terraform_remote_state.eks.outputs.worker_iam_role_arn
}
