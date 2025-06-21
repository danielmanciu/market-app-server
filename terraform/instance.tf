resource "aws_instance" "market_app_server" {
  ami                    = data.aws_ami.market_app_ami_id.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.market_app_server_kp.key_name
  vpc_security_group_ids = [aws_security_group.market_app_server_sg.id]

  tags = {
    Project = "MarketApp"
  }

  # ALTENATIVE: using user data instead of provisioners
  user_data = file("${path.module}/../provision/market-app-server-user-data.sh")

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/Users/daniel/.ssh/id_ed25519_tf")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "${path.module}/../provision/market-app-server-provision.sh"
    destination = "/tmp/provision.sh"
  }

  provisioner "file" {
    source      = "${path.module}/../provision/market-app-server-run.sh"
    destination = "/tmp/run.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/provision.sh",
      "/tmp/provision.sh",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/run.sh",
      "/tmp/run.sh",
    ]
  }
}

resource "aws_ec2_instance_state" "market_app_instance_state" {
  instance_id = aws_instance.market_app_server.id
  state       = "running"
}