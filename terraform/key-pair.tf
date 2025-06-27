resource "aws_key_pair" "market_app_server_kp" {
  key_name   = "market-app-server-kp"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHD7Krrfn1DKPyRvNPit8G+FPDiHSFsG9wmUUg6iz2LH daniel@Daniels-MacBook-Pro.local"
}