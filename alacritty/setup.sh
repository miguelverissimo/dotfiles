#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
ALACRITTY_CONFIG_DIR="${HOME}/.config/alacritty"
ORIGIN="${CONFIGS_DIR}/alacritty.yml"
DEST="${ALACRITTY_CONFIG_DIR}/alacritty.yml"

if [ ! -d "${ALACRITTY_CONFIG_DIR}" ]; then mkdir "${ALACRITTY_CONFIG_DIR}"; fi

backup_and_symlink ${ORIGIN} ${DEST}
