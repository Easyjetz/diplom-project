output "bastion_external_ip" {
  value = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
}

output "bastion_fqdn" {
  value = "${yandex_compute_instance.bastion.name}.ru-central1.internal"
}

output "alb_external_ip" {
  value = yandex_alb_load_balancer.web_lb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}

output "web_a_fqdn" {
  value = "${yandex_compute_instance.web_a.name}.ru-central1.internal"
}

output "web_b_fqdn" {
  value = "${yandex_compute_instance.web_b.name}.ru-central1.internal"
}

output "zabbix_fqdn" {
  value = "${yandex_compute_instance.zabbix.name}.ru-central1.internal"
}

output "zabbix_ip" {
  value = yandex_compute_instance.zabbix.network_interface.0.nat_ip_address
}

output "elastic_fqdn" {
  value = "${yandex_compute_instance.elastic.name}.ru-central1.internal"
}

output "elastic_ip" {
  value = yandex_compute_instance.elastic.network_interface.0.ip_address
}

output "kibana_fqdn" {
  value = "${yandex_compute_instance.kibana.name}.ru-central1.internal"
}

output "kibana_ip" {
  value = yandex_compute_instance.kibana.network_interface.0.nat_ip_address
}