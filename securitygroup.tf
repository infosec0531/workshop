resource "aws_security_group" "app_sg" {
  vpc_id      = aws_vpc.appserver.id
  name        = var.app_sg_config.name
  description = var.app_sg_config.description
  tags = {
    Name = "App_sg"
  }

  depends_on = [aws_vpc.appserver]
}

resource "aws_security_group_rule" "appsg_rules" {
  count             = length(var.app_sg_config.rules)
  type              = var.app_sg_config.rules[count.index].type
  from_port         = var.app_sg_config.rules[count.index].from_port
  to_port           = var.app_sg_config.rules[count.index].to_port
  protocol          = var.app_sg_config.rules[count.index].protocol
  cidr_blocks       = [var.app_sg_config.rules[count.index].cidr_block]
  security_group_id = aws_security_group.app_sg.id
  depends_on = [
    aws_security_group.app_sg
  ]
}