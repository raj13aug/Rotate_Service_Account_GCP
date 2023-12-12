resource "google_service_account" "demo_sa" {
  account_id = "cloudroot7-service-account"
}

resource "time_rotating" "sa_key_rotation" {
  rotation_days = 5
}

resource "google_service_account_key" "demo_sa_key" {
  service_account_id = google_service_account.demo_sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
  keepers = {
    rotation_time = time_rotating.sa_key_rotation.rotation_rfc3339
  }
}