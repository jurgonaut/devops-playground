#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SSH_KEY=devops-playground-ec2-lamp.id_rsa
SERVER_IP=$(terraform output -raw ec2_public_ip)
ANSIBLE_TAG=${1:-}

# My project files are on a mounted drive and I cannot change the permissions of files, so as a workaround I copy
# ssh key to `tmp` and I remove it after the playbook has finished.
cp "${SSH_KEY}" "/tmp/${SSH_KEY}"
chmod 600 "/tmp/${SSH_KEY}"

cli_command=(ansible-playbook --private-key="/tmp/${SSH_KEY}" -i "${SERVER_IP}," "${SCRIPT_DIR}/../../ansible/lamp.yml")
if [ -n "${ANSIBLE_TAG}" ]; then
    cli_command+=(--tags "${ANSIBLE_TAG}")
fi
"${cli_command[@]}"
rm "/tmp/${SSH_KEY}"
