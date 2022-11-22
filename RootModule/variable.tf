## You should declare every variable you've used in the root module

# General
variable "project" {
  type = string
}

variable "region" {
  type = string
}

# VPC Module
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

# VM and ASG Module
variable "family" {
  type = string
}

variable "family-project" {
  type = string
}

variable "zone" {
  type = string
}

variable "machine-type" {
  type = string
}

variable "ssh-user" {
  type = string
}