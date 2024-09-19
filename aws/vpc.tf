resource "aws_vpc" "this" {
  cidr_block = local.vpc.cidr_block
}

resource "aws_subnet" "this" {
  for_each   = local.vpc.subnets
  vpc_id     = aws_vpc.this.id
  cidr_block = each.value.cidr_block

  tags = {
    Name = each.key
  }
}
#}
