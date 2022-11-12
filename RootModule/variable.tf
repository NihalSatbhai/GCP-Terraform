## You should declare every variable you've used in the root module

# General
variable "project" {
  type = string
}

variable "region" {
  type = string
}

# VPC Module
variable "app-public-subnet1-cidr" {
  type = string
}

variable "app-public-subnet2-cidr" {
  type = string
}

variable "app-private-subnet1-cidr" {
  type = string
}

variable "app-private-subnet2-cidr" {
  type = string
}

variable "db-private-subnet1-cidr" {
  type = string
}

variable "db-private-subnet2-cidr" {
  type = string
}

variable "public-firewall-ports" {
  type = list
}

variable "private-firewall-ports" {
  type = list
}

variable "db-firewall-ports" {
  type = list
}

# Compute Module
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