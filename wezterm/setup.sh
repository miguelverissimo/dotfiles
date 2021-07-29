#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
WEZTERM_CONFIG_DIR="${HOME}/.config/wezterm"
ORIGIN="${CONFIGS_DIR}/wezterm.lua"
DEST="${WEZTERM_CONFIG_DIR}/wezterm.lua"

if [ ! -d "${WEZTERM_CONFIG_DIR}" ]; then mkdir "${WEZTERM_CONFIG_DIR}"; fi

backup_and_symlink ${ORIGIN} ${DEST}
