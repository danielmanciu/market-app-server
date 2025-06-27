resource "aws_security_group" "market_app_server_sg" {
  name        = "market-app-server-sg"
  description = "Security group used by EC2 instances hosting MarketApp server"

  tags = {
    Project = "MarketApp"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.market_app_server_sg.id
  cidr_ipv4         = "${local.my_ipv4}/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv6" {
  security_group_id = aws_security_group.market_app_server_sg.id
  cidr_ipv6         = "${local.my_ipv6}/128"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_market_app_server_ipv4" {
  security_group_id = aws_security_group.market_app_server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 2024
  ip_protocol       = "tcp"
  to_port           = 2024
}

# resource "aws_vpc_security_group_ingress_rule" "market_app_server_sg_ipv6" {
#   security_group_id = aws_security_group.market_app_server_sg.id
#   cidr_ipv6         = aws_vpc.main.ipv6_cidr_block
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.market_app_server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.market_app_server_sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}