resource "ibm_is_ssh_key" "iac_app_key" {
  name       = "${var.project_name}-${var.environment}-key"
  public_key = var.public_key
}

data "ibm_is_image" "ds_iac_app_image" {
  name = "ibm-ubuntu-18-04-1-minimal-amd64-1"
}

resource "ibm_is_instance" "iac_app_instance" {
  count   = local.max_size
  name    = "${var.project_name}-${var.environment}-instance-${format("%02s", count.index)}"
  image   = data.ibm_is_image.ds_iac_app_image.id
  profile = "cx2-2x4"

  primary_network_interface {
    name            = "eth1"
    subnet          = ibm_is_subnet.iac_app_subnet[count.index].id
    security_groups = [ibm_is_security_group.iac_app_security_group.id]
  }

  vpc     = ibm_is_vpc.iac_app_vpc.id
  zone    = var.vpc_zone_names[count.index]
  keys    = [ibm_is_ssh_key.iac_app_key.id]
  volumes = [ibm_is_volume.iac_app_volume[count.index].id]

  user_data = <<-EOUD
            #!/bin/bash
            mkdir -p /app

            echo '${data.local_file.app.content_base64}' | base64 --decode > /app/app.py
            echo '${data.local_file.import.content_base64}' | base64 --decode > /app/import.py
            echo '${data.local_file.requirements.content_base64}' | base64 --decode > /app/requirements.txt
            echo '${data.local_file.db.content_base64}' | base64 --decode > /app/db.json

            echo '${ibm_database.iac_app_db_instance.connectionstrings.0.composed}' > /app/db_certificate.cert
            export APP_MONGODB_CERT=/app/db_certificate.cert
            export APP_MONGODB_URI=${ibm_database.iac_app_db_instance.connectionstrings.0.composed}
            export APP_PORT=${var.port}

            cd /app
            pip install -r requirements.txt
            python import.py
            python app.py &

            # https://askubuntu.com/questions/1154892/prevent-question-restart-services-during-package-upgrades-without-asking
            # echo '* libraries/restart-without-asking boolean true' | debconf-set-selections

            # With Python3:
            # apt update
            # apt install -y python3-pip
            # pip3 install json-server.py
            #
            # json-server -b :${var.port} /var/lib/db.min.json &

            # With NodeJS:
            # apt update
            # curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
            # apt-get install -y nodejs
            # npm install -g json-server
            # json-server --watch /var/lib/db.min.json --port ${var.port} --host 0.0.0.0 &
            EOUD


  tags = ["iac-${var.project_name}-${var.environment}"]
}
