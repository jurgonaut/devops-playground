#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SSH_KEY=~/.vagrant.d/insecure_private_key
ANSIBLE_TAG=${1:-}

MYSQL_DOWNLOAD_URL="https://downloads.mysql.com/archives/get/p/23/file/mysql-server_8.0.11-1ubuntu18.04_amd64.deb-bundle.tar"
MYSQL_ROOT_PASS="Password1234!"

cli_command=(ansible-playbook --private-key="${SSH_KEY}" -i hosts -u vagrant --extra-vars "variable_host=mysql mysql_download_url=${MYSQL_DOWNLOAD_URL} mysql_root_pass=${MYSQL_ROOT_PASS}" "${SCRIPT_DIR}/../../ansible/mysql.yml")
if [ -n "${ANSIBLE_TAG}" ]; then
    cli_command+=(--tags "${ANSIBLE_TAG}")
fi
"${cli_command[@]}"
