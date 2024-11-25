resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_pub_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "private_ssh_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "${var.key_pair_name}.id_rsa"
}

resource "local_file" "public_ssh_key" {
  content  = tls_private_key.rsa.public_key_openssh
  filename = "${var.key_pair_name}.id_rsa.pub"
}
