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

  user_data = <<-EOUD
            #!/bin/bash
            mkdir -p /app

            # Application script and dependencies
            echo '${data.local_file.requirements.content_base64}' | base64 --decode > /app/requirements.txt
            echo '${data.local_file.app.content_base64}' | base64 --decode > /app/app.py
            # Script and database to initially import
            echo '${data.local_file.db.content_base64}' | base64 --decode > /app/db.json
            echo '${data.local_file.import.content_base64}' | base64 --decode > /app/import.py
            # Configuration and credentials
            echo '${ibm_database.iac_app_db_instance.connectionstrings.0.certbase64}' | base64 --decode > /app/db_certificate.cert
            export PASSWORD=${var.db_admin_password}
            export APP_MONGODB_URI="${ibm_database.iac_app_db_instance.connectionstrings.0.composed}"
            export APP_PORT=${var.port}

            # Due to possible bug or incorrect use of the 'databases-for-mongodb' service:
            export APP_MONGODB_URI=$(echo $APP_MONGODB_URI | sed 's|/ibmclouddb?|/${var.db_name}?|')
            echo $APP_MONGODB_URI

            # https://askubuntu.com/questions/1154892/prevent-question-restart-services-during-package-upgrades-without-asking
            echo '* libraries/restart-without-asking boolean true' | debconf-set-selections

            # Python3 is installed by default, pip3 is not
            apt update
            apt install -y python3-pip

            # Setup and initialize the DB
            cd /app
            pip3 install -r requirements.txt
            python3 import.py

            # Start up the application
            python3 app.py &

            # With Python3:
            # apt update
            # apt install -y python3-pip
            # pip3 install json-server.py
            # json-server -b :${var.port} /app/db.json &

            # With NodeJS:
            # apt update
            # curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
            # apt-get install -y nodejs
            # npm install -g json-server
            # json-server --watch /app/db.json --port ${var.port} --host 0.0.0.0 &
            EOUD


  tags = [
    "project:${var.project_name}",
    "environment:${var.environment}",
    "name:iac-${var.project_name}-${var.environment}",
    "number:${format("%02s", count.index)}"
  ]
}
