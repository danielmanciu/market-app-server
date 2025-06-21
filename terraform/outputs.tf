output "market_app_server_public_ip" {
  description = "Public IP of MarketApp server"
  value       = aws_instance.market_app_server.public_ip
}
