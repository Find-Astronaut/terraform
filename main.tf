provider "alicloud" {
  configuration_source = "terraform-provider-alicloud/examples/vpc"
}

resource "alicloud_vpc" "vpc" {
  vpc_name = "VPC10"
  cidr_block = "30.1.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  zone_id = "cn-shenzhen-b"
  cidr_block = "30.1.0.0/21"
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_security_group" "default" {
  name = "default"
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "allow_all_tcp" {
  ip_protocol = "tcp"
  security_group_id = alicloud_security_group.default.id
  type = "ingress"
  policy = "accept"
  port_range = "1/65535"
  priority = 1
  cidr_ip = "0.0.0.0/0"
  nic_type = "intranet"
}