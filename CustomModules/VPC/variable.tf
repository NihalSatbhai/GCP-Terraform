## You should declare every variable you've used in this module

variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "app-public-subnet-cidrs" {
  type = list(string)
}

variable "app-private-subnet-cidrs" {
  type = list(string)
}

variable "db-private-subnet-cidrs" {
  type = list(string)
}

variable "proxy-subnet-cidr" {
  type = string
}

variable "public-firewall-ports" {
  type = list(string)
}

variable "private-firewall-ports" {
  type = list(string)
}

variable "db-firewall-ports" {
  type = list(string)
}