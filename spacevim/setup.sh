#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
SPACEVIM_D_DIR="${HOME}/.SpaceVim.d"
AUTOLOAD_DIR="${SPACEVIM_D_DIR}/autoload"
if [ ! -d "${AUTOLOAD_DIR}" ]; then mkdir -p "${AUTOLOAD_DIR}"; fi

for CONFIG_FILE in init.toml; do
  ORIGIN="${CONFIGS_DIR}/${CONFIG_FILE}"
  DEST="${SPACEVIM_D_DIR}/${CONFIG_FILE}"

  backup_and_symlink ${ORIGIN} ${DEST}
done

for CONFIG_FILE in *.vim; do
  ORIGIN="${CONFIGS_DIR}/${CONFIG_FILE}"
  DEST="${AUTOLOAD_DIR}/${CONFIG_FILE}"

  backup_and_symlink ${ORIGIN} ${DEST}
done
