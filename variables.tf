variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

####################
# EKS remote state #
####################
variable "eks_bucket" {
  description = "Name of the bucket where eks state is stored"
  type        = string
}

variable "eks_state_key" {
  description = "Key where the state file of the eks is stored"
  type        = string
}

variable "eks_state_region" {
  description = "Region where the state file of the eks is stored"
  type        = string
}

###########
# KMS Key #
###########
variable "aws_kms_key_deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days"
  default     = 30
}

#############
# S3 bucket #
#############
variable "vault_bucket_name" {
  description = "Name of the bucket where Vault will store keys and backups"
  type        = string
}