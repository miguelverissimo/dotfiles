#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
HERDR_CONFIG_DIR="${HOME}/.config/herdr"
ORIGIN="${CONFIGS_DIR}/config.toml"
DEST="${HERDR_CONFIG_DIR}/config.toml"

if [ ! -d "${HERDR_CONFIG_DIR}" ]; then mkdir -p "${HERDR_CONFIG_DIR}"; fi

backup_and_symlink ${ORIGIN} ${DEST}
