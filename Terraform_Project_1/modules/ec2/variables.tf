variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "ami_id" {
  description = "AMI ID for the instance (if null, uses latest Amazon Linux 2)"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch instances in"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Associate public IP address with instance"
  type        = bool
  default     = true
}

variable "associate_eip" {
  description = "Associate Elastic IP with instance"
  type        = bool
  default     = false
}

variable "root_volume_type" {
  description = "Root volume type"
  type        = string
  default     = "gp2"
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 20
}

variable "delete_on_termination" {
  description = "Delete volume on instance termination"
  type        = bool
  default     = true
}

variable "encrypted_volumes" {
  description = "Enable encryption for EBS volumes"
  type        = bool
  default     = false
}

variable "user_data" {
  description = "User data script for instance initialization"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
