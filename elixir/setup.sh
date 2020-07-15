#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

for CONFIG_FILE in iex.exs; do
  ORIGIN="${CONFIGS_DIR}/${CONFIG_FILE}"
  DEST="${HOME}/.${CONFIG_FILE}"

  backup_and_symlink ${ORIGIN} ${DEST}
done

ELIXIR_LS_DIR=${HOME}/DEV/_UTIL
DEST=${HOME}/elixir-ls

if [ ! -d "${ELIXIR_LS_DIR}" ]; then
  echo "Configuring elixir-ls"
  ./config-elixir-ls.sh
else
  echo "${ELIXIR_LS_DIR} already present, skipping cloning"

  if [ ! -L "${DEST}" ]; then
    echo "Symlinking ${DEST} to ${ELIXIR_LS_DIR}"
    ln -s ${ELIXIR_LS_DIR} ${DEST}
  else
    echo "${DEST} present, skipping symlinking"
  fi
fi
