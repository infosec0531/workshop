resource "aws_vpc" "appserver" {
  cidr_block = var.vpc_app
  tags = {
    Name = local.name
  }
}

resource "aws_subnet" "subnet_app" {
  count             = length(var.app_subnet)
  vpc_id            = aws_vpc.appserver.id
  cidr_block        = cidrsubnet(var.vpc_app, 8, count.index)
  availability_zone = var.subnet_azs[count.index]
  tags = {
    Name = var.app_subnet[count.index]
  }
  depends_on = [aws_vpc.appserver]
}

data "aws_route_table" "default" {
  vpc_id     = aws_vpc.appserver.id
  depends_on = [aws_vpc.appserver]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.appserver.id

  tags = {
    Name = "main"
  }

  depends_on = [
    aws_vpc.appserver
  ]
}

resource "aws_route" "igwroute" {
  route_table_id         = data.aws_route_table.default.id
  destination_cidr_block = local.anywhere
  gateway_id             = aws_internet_gateway.igw.id

  depends_on = [
    aws_vpc.appserver,
    aws_internet_gateway.igw
  ]
}