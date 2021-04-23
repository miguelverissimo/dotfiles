#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
SPACEVIM_D_DIR="${HOME}/.SpaceVim.d"

backup_and_symlink "${CONFIGS_DIR}" "${SPACEVIM_D_DIR}"
