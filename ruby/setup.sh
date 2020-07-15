#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

for CONFIG_FILE in aprc gemrc irbrc pryrc rdebugrc ruby-version; do
  ORIGIN="${CONFIGS_DIR}/${CONFIG_FILE}"
  DEST="${HOME}/.${CONFIG_FILE}"

  backup_and_symlink ${ORIGIN} ${DEST}
done


# BUNDLER CONFIG
BUNDLER_CONFIG_DIR="${HOME}/.bundler"
ORIGIN="${CONFIGS_DIR}/bundler_config"
DEST="${BUNDLER_CONFIG_DIR}/config"

if [ ! -d "${BUNDLER_CONFIG_DIR}" ]; then mkdir "${BUNDLER_CONFIG_DIR}"; fi

backup_and_symlink ${ORIGIN} ${DEST}
