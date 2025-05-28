locals {
  subnet_map = jsondecode(data.aws_ssm_parameter.subnet_list.value)
  private_subnet_ids = nonsensitive(local.subnet_map["private"])
  public_subnet_ids = nonsensitive(local.subnet_map["public"])
  private_subnet_cidr_values = values(data.aws_subnet.private_subnets).*.cidr_block
  public_subnet_cidr_values = values(data.aws_subnet.public_subnets).*.cidr_block
}