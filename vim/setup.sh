#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
ORIGIN=${CONFIGS_DIR}/vimrc
DEST="${HOME}/.vimrc"

backup_and_symlink ${ORIGIN} ${DEST}
