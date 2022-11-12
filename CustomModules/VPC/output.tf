## Define each output whose value you want to use in other modules or in root module (Based on your requirements)

output "public-subnet1-name" {
  value = google_compute_subnetwork.application-public-subnet1.name
}