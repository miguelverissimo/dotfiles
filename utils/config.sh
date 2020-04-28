#!/usr/bin/env bash

set -e
CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

for UTILITY_FILE in colortest; do
  SYMLINK_PATH=/usr/local/bin/${UTILITY_FILE}

  if [ "$SYMLINK_PATH" == "/usr/local/bin/" ]; then
    echo "ABORTING: Something is wrong with this path: ${SYMLINK_PATH}"
    exit 1
  fi

  if [ -e "$SYMLINK_PATH" ]; then
    echo "removing previous symlink in ${SYMLINK_PATH}"
    rm -f ${SYMLINK_PATH}
  fi
  echo "symlinking ${UTILITY_FILE} to ${SYMLINK_PATH}"
  ln -s ${CONFIGS_DIR}/${UTILITY_FILE} ${SYMLINK_PATH}
done
