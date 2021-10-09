provider "alicloud" {
  configuration_source = "terraform-provider-alicloud/examples/vpc"
}
// 创建VPC
resource "alicloud_vpc" "vpc" {
  vpc_name = "VPC10"
  cidr_block = "30.0.0.0/12"
}
//创建 vSwitch 定义地址 地区
resource "alicloud_vswitch" "vsw" {
  zone_id = "cn-guangzhou-a"
  cidr_block = "30.1.0.0/21"
  vpc_id = alicloud_vpc.vpc.id
}
// 默认的安全组
resource "alicloud_security_group" "default" {
  name = "default"
  vpc_id = alicloud_vpc.vpc.id
}
//定义策略
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