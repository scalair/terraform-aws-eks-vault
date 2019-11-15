# KMS
data "template_file" "kms" {
  template = "${file("kms-policy.json")}"

  vars = {
    iam_user_arn        = data.terraform_remote_state.eks.outputs.iam_user_arn
    worker_iam_role_arn = data.terraform_remote_state.eks.outputs.worker_iam_role_arn
  }
}

resource "aws_kms_key" "vault" {
  description             = "KMS key used by Vault"
  policy                  = data.template_file.kms.rendered
  deletion_window_in_days = var.aws_kms_key_deletion_window_in_days
  tags                    = var.tags
}

resource "aws_kms_alias" "vault" {
  name_prefix   = "alias/eks-vault-"
  target_key_id = "${aws_kms_key.vault.key_id}"
}

# S3
resource "aws_s3_bucket" "vault" {
  bucket = var.vault_bucket_name
  acl    = "private"
  tags   = var.tags

  versioning {
    enabled = true
  }
}

# Worker policy
data "template_file" "worker" {
  template = "${file("worker-policy.json")}"

  vars = {
    kms_key_arn   = aws_kms_key.vault.arn
    s3_bucket_arn = aws_s3_bucket.vault.arn
  }
}

resource "aws_iam_policy" "eks_vault" {
  name_prefix = "eks-vault-"
  description = "Policy required by Vault"

  policy = data.template_file.worker.rendered
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = data.terraform_remote_state.eks.outputs.worker_iam_role_name
  policy_arn = aws_iam_policy.eks_vault.arn
}
