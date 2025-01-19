#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SSH_KEY=~/.vagrant.d/insecure_private_key
ANSIBLE_TAG=${1:-}

cli_command=(ansible-playbook --private-key="${SSH_KEY}" -i hosts -u vagrant "${SCRIPT_DIR}/../../ansible/wireguard.yml")
if [ -n "${ANSIBLE_TAG}" ]; then
    cli_command+=(--tags "${ANSIBLE_TAG}")
fi
"${cli_command[@]}"
