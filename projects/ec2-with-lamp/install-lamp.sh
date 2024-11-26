#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SSH_KEY=devops-playground-ec2.id_rsa
SERVER_IP=$(terraform output -raw ec2_public_ip)

# My project files are on a mounted drive and I cannot change the permissions of files, so as a workaround I copy
# ssh key to `tmp` and I remove it after the playbook has finished.
cp "${SSH_KEY}" "/tmp/${SSH_KEY}"
chmod 600 "/tmp/${SSH_KEY}"
ansible-playbook --private-key="/tmp/${SSH_KEY}" -i "${SERVER_IP}", "${SCRIPT_DIR}/../../ansible/webserver.yml"
rm "/tmp/${SSH_KEY}"
