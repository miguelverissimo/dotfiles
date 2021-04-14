#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
LAZYGIT_CONFIG_DIR="${HOME}/.config/lazygit"
ORIGIN="${CONFIGS_DIR}/config.yml"
DEST="${LAZYGIT_CONFIG_DIR}/config.yml"

if [ ! -d "${LAZYGIT_CONFIG_DIR}" ]; then mkdir "${LAZYGIT_CONFIG_DIR}"; fi

backup_and_symlink ${ORIGIN} ${DEST}
