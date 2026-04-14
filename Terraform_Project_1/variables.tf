variable "aws_region" {
  description = "AWS region for provider operations"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use for provider authentication"
  type        = string
  default     = null
}

variable "aws_shared_credentials_file" {
  description = "Path to shared AWS credentials file"
  type        = string
  default     = null
}

variable "project_name" {
  description = "Project name used in tags"
  type        = string
  default     = "multienv-iac"
}

variable "environment" {
  description = "Deployment environment used in tags"
  type        = string
  default     = "dev"
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "example-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT gateway for private subnet outbound access"
  type        = bool
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "Whether to automatically assign public IPs to public subnet instances"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Name for the security group"
  type        = string
  default     = "example-sg"
}

variable "security_group_description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for EC2 instances"
}

variable "ingress_rules" {
  description = "Ingress rules for the security group"
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
    description     = optional(string)
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH access"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP access"
    }
  ]
}

variable "egress_rules" {
  description = "Egress rules for the security group"
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
    description     = optional(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
}

variable "instance_name" {
  description = "Base name for EC2 instances"
  type        = string
  default     = "example-instance"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Associate public IP addresses with EC2 instances"
  type        = bool
  default     = true
}

variable "associate_eip" {
  description = "Assign Elastic IPs to EC2 instances"
  type        = bool
  default     = false
}

variable "root_volume_size" {
  description = "Root EBS volume size for EC2 instances"
  type        = number
  default     = 20
}

variable "encrypted_volumes" {
  description = "Whether EBS volumes are encrypted"
  type        = bool
  default     = false
}

variable "user_data" {
  description = "EC2 user data script"
  type        = string
  default     = ""
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "example-terraform-bucket-123456"
}

variable "enable_versioning" {
  description = "Enable S3 versioning"
  type        = bool
  default     = false
}

variable "enable_encryption" {
  description = "Enable S3 server-side encryption"
  type        = bool
  default     = true
}

variable "encryption_algorithm" {
  description = "SSE algorithm for S3 bucket"
  type        = string
  default     = "AES256"
}

variable "block_public_access" {
  description = "Block public access on the S3 bucket"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Enable access logging for the S3 bucket"
  type        = bool
  default     = false
}
