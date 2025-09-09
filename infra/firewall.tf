resource "google_compute_firewall" "python-gke-node-firewall" {
  name =  "python-gke-node-firewall"
  network =  module.vpc.network_name


 source_ranges = ["0.0.0.0/0"]

  target_tags = ["gke-node"] # Make sure this matches your node pool tags

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}
