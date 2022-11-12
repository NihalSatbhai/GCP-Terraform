## Calling output values from custom modules which will being used in root module
output "public-subnet1-name" {
  value = module.VPC.public-subnet1-name
}