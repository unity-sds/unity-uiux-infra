locals {
  subnet_map = jsondecode(data.aws_ssm_parameter.subnet_list.value)
  private_subnet_ids = nonsensitive(local.subnet_map["private"])
  public_subnet_ids = nonsensitive(local.subnet_map["public"])
}