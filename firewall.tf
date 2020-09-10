#-------------------------ssh_firewall
resource "google_compute_firewall" "ssh_firewall" {
  name    = "allow-ssh"
  network = "${google_compute_network.my_vpc_network.name}"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  source_tags = ["ssh"]
}
#-------------------------db_firewall
resource "google_compute_firewall" "db_firewall" {
  name    = "allow-db"
  network = "${google_compute_network.my_vpc_network.name}"
  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }
  source_ranges = ["0.0.0.0/0"]
  source_tags = ["db"]
}