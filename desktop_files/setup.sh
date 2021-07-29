#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

for DESKTOP_FILE in *.desktop do
  ORIGIN="${CONFIGS_DIR}/${DESKTOP_FILE}"
  DEST="/usr/local/bin/${DESKTOP_FILE}"

  if [ "$DEST" == "/usr/local/bin/" ]; then
    echo "ABORTING: Something is wrong with this path: ${DEST}"
    exit 1
  fi

  backup_and_symlink ${ORIGIN} ${DEST} sudo
done
