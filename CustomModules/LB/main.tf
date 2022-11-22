resource "google_compute_forwarding_rule" "external-lb" {
  depends_on = [var.proxy-subnet]
  name       = "external-lb"
  region     = var.region

  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.lb-proxy.id
  network               = var.network
  network_tier          = "STANDARD"
}

resource "google_compute_region_target_http_proxy" "lb-proxy" {
  region  = var.region
  name    = "lb-proxy"
  url_map = google_compute_region_url_map.lb-map.id
}

resource "google_compute_region_url_map" "lb-map" {
  region          = var.region
  name            = "lb-map"
  default_service = google_compute_region_backend_service.backend-service.id
}

resource "google_compute_region_backend_service" "backend-service" {
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend {
    group           = var.igm
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }

  region      = var.region
  name        = "backend-service"
  protocol    = "HTTP"
  timeout_sec = 30

  health_checks = [var.health-check]
}