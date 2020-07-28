#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

for UTILITY_FILE in pivnet load-pivnet-env colortest pc; do
  ORIGIN="${CONFIGS_DIR}/${UTILITY_FILE}"
  DEST="/usr/local/bin/${UTILITY_FILE}"

  if [ "$DEST" == "/usr/local/bin/" ]; then
    echo "ABORTING: Something is wrong with this path: ${DEST}"
    exit 1
  fi

  backup_and_symlink ${ORIGIN} ${DEST} sudo
done
