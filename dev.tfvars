vpc_app    = "10.10.0.0/16"
app_subnet = ["app1", "app2"]
subnet_azs = ["us-west-1a", "us-west-1b"]
app_sg_config = {
  name        = "appsg"
  description = "this is appsecurity group"
  rules = [{
    type       = "ingress"
    from_port  = 8080
    to_port    = 8080
    protocol   = "tcp"
    cidr_block = "10.10.0.0/16"
    },
    {
      type       = "ingress"
      from_port  = 22
      to_port    = 22
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
    },
    {
      type       = "egress"
      from_port  = 0
      to_port    = 65535
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }
  ]
}
