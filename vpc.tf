resource "alicloud_vpc" "vpc" {
  zone_id = "cn-shenzhen-a"
  cidr_block = "30.1.1.0/24"
  vpc_id = "VPC100"
}