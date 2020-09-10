#---------------------------Ansible Provision
resource "null_resource" "ansibleProvision" {
  depends_on = ["google_compute_instance.ansible", "google_container_cluster.primary", "null_resource.update_file_db"]
  connection {
    host = "${google_compute_instance.ansible.network_interface.0.access_config.0.nat_ip}"
    type = "ssh"
    user = "centos"
    private_key = "${file("${var.pvt_key}")}"
    agent = "false"
  }
  provisioner "file" {
     source = "${var.pvt_key}"
     destination = "/home/centos/.ssh/id_rsa"
     }
  provisioner "remote-exec" {
    inline = ["sudo chmod 600 /home/centos/.ssh/id_rsa"]
  }
  provisioner "file" {
     source = "${var.key}"
     destination = "/home/centos/.ssh/key.json"
     }
  provisioner "remote-exec" {
    inline = ["sudo chmod 600 /home/centos/.ssh/key.json"]
  }
  provisioner "remote-exec" {
    inline = [ "sudo yum -y update", "sudo yum -y install ansible"]
  }
  provisioner "remote-exec" {
    inline = [ "rm -rf /tmp/ansible" ]
  }
  provisioner "file" {
    source = "ansible"
    destination = "/home/centos/ansible"
  }
    provisioner "file" {
    source = "kuber"
    destination = "/home/centos/kuber"
  }
  provisioner "remote-exec" {
    inline = ["sudo sed -i -e 's+#host_key_checking+host_key_checking+g' /etc/ansible/ansible.cfg"]
  }
  provisioner "remote-exec" {
    inline = ["ansible-playbook -i /home/centos/ansible/hosts.txt /home/centos/ansible/playbook.yml"]
  }
}

#---------------------------generate inventory file
resource "null_resource" "update_file_db" {
  provisioner "local-exec" {
    command = "echo [db] >> ${var.hosts} && echo ${google_compute_instance.server-db.name} ansible_host=${google_compute_instance.server-db.network_interface.0.network_ip} >> ${var.hosts}"
  }
    depends_on = [google_compute_instance.server-db]
}
#---------------------------echo dtester ip
resource "null_resource" "update_file_ingress" {
  provisioner "local-exec" {
    command = "echo dtester_ip: ${google_compute_address.my_address.address}>> ${var.ansible-vars}"
  }
    depends_on = [google_compute_address.my_address]
}
