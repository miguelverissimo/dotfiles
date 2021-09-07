#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
LAZYDOCKER_CONFIG_DIR="${HOME}/.config/lazydocker"
ORIGIN="${CONFIGS_DIR}/config.yml"
DEST="${LAZYDOCKER_CONFIG_DIR}/config.yml"

if [ ! -d "${LAZYDOCKER_CONFIG_DIR}" ]; then mkdir "${LAZYDOCKER_CONFIG_DIR}"; fi

backup_and_symlink ${ORIGIN} ${DEST}
