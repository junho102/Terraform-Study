variable "prefix" {
  description = "project name"
  default = "jh"
}

variable "environment" {
  default = "test"
}

variable "region" {
  default = "Korea Central"
}


### network ###
###############
variable "address_space" {
  description = "virtual network address space"
  default = "10.0.0.0/16"
}

variable "pub_subnet_prefix" {
  description = "public subnet address prefixes"
  default = "10.0.0.0/24"
}


### virtual machine ###
#######################
variable "image_publisher" {
  description = "Name of the publisher of the image (az vm image list)"
  default     = "Canonical"
}

variable "image_offer" {
  description = "Name of the offer (az vm image list)"
  default     = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  description = "Image SKU to apply (az vm image list)"
  default     = "22_04-lts"
}

variable "image_version" {
  description = "Version of the image to apply (az vm image list)"
  default     = "latest"
}

variable "vm_size" {
  type = list(string)
  default = ["Standard_DS1_v2", "Standard_D2s_v3", "Standard_B2ms"]
}

variable "vm_username" {
  default = "adminuser"
}