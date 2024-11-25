resource "aws_security_group" "ecs_sg" {
  vpc_id = "${var.vpc_id}"
  name   = "${var.name_prefix}"
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
  security_group_id = aws_security_group.ecs_sg.id

  for_each = toset(var.ingress)

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = each.value
  ip_protocol = "tcp"
  to_port     = each.value
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.ecs_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
