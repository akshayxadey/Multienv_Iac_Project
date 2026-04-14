module "vpc" {
  source = "./modules/vpc"

  vpc_name              = var.vpc_name
  cidr_block            = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  availability_zones    = var.availability_zones
  enable_nat_gateway    = var.enable_nat_gateway
  map_public_ip_on_launch = var.map_public_ip_on_launch

  common_tags = local.common_tags
}

module "security_group" {
  source = "./modules/security_group"

  security_group_name        = var.security_group_name
  security_group_description = var.security_group_description
  vpc_id                      = module.vpc.vpc_id

  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules

  common_tags = local.common_tags

  depends_on = [module.vpc]
}

module "ec2" {
  source = "./modules/ec2"

  instance_name               = var.instance_name
  instance_type               = var.instance_type
  instance_count              = var.instance_count
  subnet_ids                  = module.vpc.public_subnet_ids
  security_group_id           = module.security_group.security_group_id
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  associate_eip               = var.associate_eip
  root_volume_size            = var.root_volume_size
  encrypted_volumes           = var.encrypted_volumes
  user_data                   = var.user_data

  common_tags = local.common_tags

  depends_on = [module.security_group]
}

module "s3" {
  source = "./modules/s3"

  bucket_name         = var.bucket_name
  enable_versioning   = var.enable_versioning
  enable_encryption   = var.enable_encryption
  encryption_algorithm = var.encryption_algorithm
  block_public_access = var.block_public_access
  enable_logging      = var.enable_logging

  common_tags = local.common_tags
}

locals {
  common_tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  )
}