#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
ORIGIN="${CONFIGS_DIR}"
DEST="${HOME}/.config/nvim/user"

backup_and_symlink ${ORIGIN} ${DEST}
