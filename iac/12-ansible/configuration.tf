resource "null_resource" "waiter" {
  depends_on = [ibm_is_instance.iac_app_instance, ibm_is_floating_ip.iac_app_floating_ip]

  count = var.max_size

  provisioner "remote-exec" {
    inline = ["hostname"]

    connection {
      user        = "ubuntu"
      host        = ibm_is_floating_ip.iac_app_floating_ip[count.index].address
      private_key = file(pathexpand(var.private_key_file))
      timeout     = "5m"
    }
  }
}

data "template_file" "inventory" {
  depends_on = [null_resource.waiter]

  template = file("${path.module}/templates/inventory.tmpl.yaml")
  vars = {
    private_key_file     = pathexpand(var.private_key_file)
    logdna_ingestion_key = var.logdna_ingestion_key
    project_name         = var.project_name
    environment          = var.environment
    logdna_api_host      = var.logdna_api_host
    logdna_log_host      = var.logdna_log_host
    appservers           = format("    appservers:\n      hosts:\n%s", join("", formatlist("        %s:\n", ibm_is_floating_ip.iac_app_floating_ip[*].address)))
  }
}

resource "local_file" "inventory" {
  filename = "${path.module}/inventory.yaml"
  content  = data.template_file.inventory.rendered
}

resource "null_resource" "ansible" {
  depends_on = [local_file.inventory]

  provisioner "local-exec" {
    command = "ansible-playbook -i ${path.module}/inventory.yaml ${path.module}/playbook.yaml | tee -a ${path.module}/ansible.log"
  }
}
