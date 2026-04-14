data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "this" {
  count                = var.instance_count
  ami                  = var.ami_id != null ? var.ami_id : data.aws_ami.amazon_linux.id
  instance_type        = var.instance_type
  subnet_id            = var.subnet_ids[count.index % length(var.subnet_ids)]
  security_groups      = []
  vpc_security_group_ids = [var.security_group_id]

  associate_public_ip_address = var.associate_public_ip_address

  key_name = var.key_name

  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    delete_on_termination = var.delete_on_termination
    encrypted             = var.encrypted_volumes
  }

  user_data = base64encode(var.user_data)

  tags = merge(
    var.common_tags,
    {
      Name = "${var.instance_name}-${count.index + 1}"
    }
  )

  depends_on = [var.security_group_id]
}

resource "aws_eip" "this" {
  count    = var.associate_eip ? var.instance_count : 0
  instance = aws_instance.this[count.index].id
  domain   = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.instance_name}-eip-${count.index + 1}"
    }
  )

  depends_on = [aws_instance.this]
}
