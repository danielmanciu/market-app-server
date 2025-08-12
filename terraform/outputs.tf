output "market_app_server_public_ip" {
  description = "Public IP of MarketApp server"
  value       = [for instance in aws_instance.market_app_server : instance.public_ip]
}

resource "local_file" "market_app_server_ansible_host_vars" {
  count = var.market_app_server_count
  content = format("AWS_EC2_IP: %s", aws_instance.market_app_server[count.index].public_ip)
  filename = "${path.module}/../ansible/host_vars/market_app_${count.index + 1}"
  file_permission = "0644"
}
