# Terraform AWS EKS Vault
Terraform modules to create the required environment for a Vault cluster on AWS EKS.

This will creates:
* An S3 buckets to store Vault unseal keys and backups
* A KMS key to encrypt/decrypt Vault unseal keys
* A policy to allow worker nodes to interact with the S3 bucket and KMS key (should be replace with [kube2iam](https://github.com/jtblin/kube2iam) at some point)

This module must be used with [terraform-aws-eks](https://github.com/scalair/terraform-aws-eks) module.