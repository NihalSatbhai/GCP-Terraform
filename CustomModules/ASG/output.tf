output "igm-instance-group" {
  value = google_compute_instance_group_manager.private-igm.instance_group
}

output "health-check-id" {
  value = google_compute_region_health_check.http-health-check.id
}