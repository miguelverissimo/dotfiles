#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
KITTY_CONFIG_DIR="${HOME}/.config/kitty"
ORIGIN="${CONFIGS_DIR}/kitty.conf"
DEST="${KITTY_CONFIG_DIR}/kitty.conf"

if [ ! -d "${KITTY_CONFIG_DIR}" ]; then mkdir "${KITTY_CONFIG_DIR}"; fi

backup_and_symlink ${ORIGIN} ${DEST}
