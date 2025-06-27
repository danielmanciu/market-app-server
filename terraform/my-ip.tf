data "http" "my_ipv4" {
  url = "https://api.ipify.org"
}

data "http" "my_ipv6" {
  url = "https://api6.ipify.org"
}
