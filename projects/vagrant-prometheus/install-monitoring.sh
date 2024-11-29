#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SSH_KEY=~/.vagrant.d/insecure_private_key
ANSIBLE_TAG=${1:-}

# setup the nodes
cli_command=(ansible-playbook --private-key="${SSH_KEY}" -i hosts -u vagrant --extra-vars "variable_host=nodes" "${SCRIPT_DIR}/../../ansible/node_exporter.yml")
if [ -n "${ANSIBLE_TAG}" ]; then
    cli_command+=(--tags "${ANSIBLE_TAG}")
fi
"${cli_command[@]}"

# setup the monitor
cli_command=(ansible-playbook --private-key="${SSH_KEY}" -i hosts -u vagrant --extra-vars "variable_host=monitor" "${SCRIPT_DIR}/../../ansible/prometheus.yml")
if [ -n "${ANSIBLE_TAG}" ]; then
    cli_command+=(--tags "${ANSIBLE_TAG}")
fi
"${cli_command[@]}"
