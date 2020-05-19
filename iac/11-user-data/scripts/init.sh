#!/bin/bash
echo '${json_db_b64}' | base64 --decode > /var/lib/db.min.json

# https://askubuntu.com/questions/1154892/prevent-question-restart-services-during-package-upgrades-without-asking
echo '* libraries/restart-without-asking boolean true' | debconf-set-selections

# With Python3:
# apt update
# apt install -y python3-pip
# pip3 install json-server.py
#
# json-server -b :${port} /var/lib/db.min.json &

# With NodeJS:
apt update
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
apt-get install -y nodejs
npm install -g json-server

json-server --watch /var/lib/db.min.json --port ${port} --host 0.0.0.0 &
