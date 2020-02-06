locals {
  is_t_instance_type = replace(var.instance_type, "/^t[23]{1}\\..*$/", "1") == "1" ? true : false
}

resource "aws_instance" "this" {
  count = var.instance_count

  ami              = var.ami
  instance_type    = var.instance_type
  subnet_id = length(var.network_interface) > 0 ? null : element(
    distinct(compact(concat([var.subnet_id], var.subnet_ids))),
    count.index,
  )
  key_name               = var.key_name
  # vpc_security_group_ids = var.vpc_security_group_ids
	tags = {
    Name = "bastion host"
    created_by = "${var.created_by}"
  }

  connection {
    user = "${var.ssh_user}"
    private_key = "${file(var.ssh_private_key_location)}"
    agent = false
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/terraform/"
    ]
  }

  provisioner "file" {
    source = "../files/bastion/"
    destination = "/tmp/terraform"
  }

  provisioner "file" {
    source = "${var.ssh_private_key_location}"
    destination = "/home/${var.ssh_user}/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 0600 /home/${var.ssh_user}/.ssh/id_rsa",
      "chmod a+x /tmp/terraform/provision.sh",
      "/tmp/terraform/provision.sh ${var.ssh_user}"
    ]
  }
}
