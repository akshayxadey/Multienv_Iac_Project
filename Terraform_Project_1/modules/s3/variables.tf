variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "acl" {
  description = "ACL for the bucket (private, public-read, etc.)"
  type        = string
  default     = null
}

variable "enable_versioning" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}

variable "enable_encryption" {
  description = "Enable server-side encryption"
  type        = bool
  default     = true
}

variable "encryption_algorithm" {
  description = "Encryption algorithm (AES256 or aws:kms)"
  type        = string
  default     = "AES256"
}

variable "block_public_access" {
  description = "Block all public access to the bucket"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Enable access logging"
  type        = bool
  default     = false
}

variable "log_bucket" {
  description = "Target bucket for access logs (if null, logs to same bucket)"
  type        = string
  default     = null
}

variable "log_prefix" {
  description = "Prefix for access logs"
  type        = string
  default     = "logs/"
}

variable "lifecycle_rules" {
  description = "Lifecycle rules for the bucket"
  type = list(object({
    id                             = string
    status                         = string
    prefix                         = optional(string)
    expiration                     = optional(object({ days = number }))
    transitions                    = optional(list(object({ days = number, storage_class = string })))
    noncurrent_version_expiration  = optional(object({ days = number }))
  }))
  default = []
}

variable "cors_rules" {
  description = "CORS rules for the bucket"
  type = list(object({
    allowed_methods = list(string)
    allowed_origins = list(string)
    allowed_headers = optional(list(string))
    expose_headers  = optional(list(string))
    max_age_seconds = optional(number)
  }))
  default = []
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
