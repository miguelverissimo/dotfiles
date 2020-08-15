#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
MODULES_DIR="${HOME}/.dotfiles/modules"

pushd modules
  for CONFIG_FILE in *.module; do
    ORIGIN="${SCRIPT_DIR}/modules/${CONFIG_FILE}"
    DEST="${MODULES_DIR}/${CONFIG_FILE}"

    backup_and_symlink ${ORIGIN} ${DEST}
  done
popd
