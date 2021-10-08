provider "alicloud" {
  configuration_source = "terraform-provider-alicloud/examples/vpc"
}

resource "alicloud_vpc" "main" {
  # VPC名称
  vpc_name       = "VPC10"
  # VPC地址块
  cidr_block = "30.1.0.0/21"
}

resource "alicloud_vswitch" "main" {
  # VPC ID
  vpc_id            = alicloud_vpc.main.id
  # 交换机地址块
  cidr_block        = "30.1.1.0/24"
  # 可用区
  zone_id = "cn-shenzhen-a"
  # 资源依赖,会优先创建该依赖资源
  depends_on = [alicloud_vpc.main]
}