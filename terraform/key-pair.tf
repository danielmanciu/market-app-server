resource "aws_key_pair" "market_app_server_kp" {
  key_name   = "market-app-server-kp"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINUhuaGmU6XTxP5st3xmq7uWhlmBgHYqdOUiui93tAi0 daniel@Daniels-MacBook-Pro.local"
}