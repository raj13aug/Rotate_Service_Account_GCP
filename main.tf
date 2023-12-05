resource "google_service_account" "demo_sa" {
  account_id = "cloudroot7-service-account"
  project    = "devops-counsel-demo"
}

resource "time_rotating" "sa_key_rotation" {
  rotation_days = 1
}

resource "google_service_account_key" "demo_sa_key" {
  service_account_id = google_service_account.demo_sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
  keepers = {
    rotation_time = time_rotating.sa_key_rotation.rotation_rfc3339
  }
}

resource "local_file" "sa_json_file" {
  content  = base64decode(google_service_account_key.demo_sa_key.private_key)
  filename = "${path.module}/demo_key.json"

}

# https://cloud.google.com/iam/docs/key-rotation