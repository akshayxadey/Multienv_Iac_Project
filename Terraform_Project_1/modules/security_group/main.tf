resource "aws_security_group" "this" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = var.security_group_name
    }
  )
}

resource "aws_security_group_rule" "ingress" {
  count = length(var.ingress_rules)

  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = try(var.ingress_rules[count.index].cidr_blocks, null)
  security_groups   = try(var.ingress_rules[count.index].security_groups, null)
  description       = try(var.ingress_rules[count.index].description, "")
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "egress" {
  count = length(var.egress_rules)

  type              = "egress"
  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  protocol          = var.egress_rules[count.index].protocol
  cidr_blocks       = try(var.egress_rules[count.index].cidr_blocks, null)
  security_groups   = try(var.egress_rules[count.index].security_groups, null)
  description       = try(var.egress_rules[count.index].description, "")
  security_group_id = aws_security_group.this.id
}
