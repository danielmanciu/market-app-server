locals {
  my_ipv4 = trimspace(data.http.my_ipv4.response_body)
}

locals {
  my_ipv6 = trimspace(data.http.my_ipv6.response_body)
}