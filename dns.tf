#------------aws dns
data "aws_route53_zone" "selected" {
  name = "${var.dns_zone_name}"
}
resource "aws_route53_record" "my_dns_backend" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name = "dtester-demo.${data.aws_route53_zone.selected.name}"
  type = "A"
  ttl     = "300"
  records = ["${google_compute_address.my_address.address}"]
  depends_on = [google_compute_address.my_address]
}