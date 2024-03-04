variable "resource_group_name" {
    description = "name of the rg"
    type = string
    default = "stats-team"
}
variable "vn-02" {
    description = "name of the virtual network"
    type = string
    default = "stats-vn"
}
variable "subnet-o2" {
    description = "name of the subnet"
    type = string
    default = "stats-subnet"

}
variable "address_space" {
    description = "addresses for th vn"
    type = list
    default =  ["10.0.0.0/8"]
}
variable "address_prefixes" {
    description = "value"
    type = list
  default = ["10.2.128.0/17"]
}
variable "nic-02" {
    description = "name of network interface"
    type = string
    default = "stats-nic"
}
variable "vm-02" {
    description = "name of virtual machine"
    type = string
    default = "stats-virtual-machine"
}
  
