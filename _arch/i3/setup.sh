#!/usr/bin/env bash

source ../../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
DEST_DIR="${HOME}/.config/i3"

if [ ! -d "${DEST_DIR}" ]; then mkdir "${DEST_DIR}"; fi

for CONFIG_FILE in config; do
  ORIGIN="${CONFIGS_DIR}/${CONFIG_FILE}"
  DEST="${DEST_DIR}/${CONFIG_FILE}"

  backup_and_symlink ${ORIGIN} ${DEST}
done

I3_ZSH_PATH="${HOME}/.dotfiles/zsh/asdf.zsh"

cat << EOF > "${I3_ZSH_PATH}"
export TERMINAL="alacritty"
export BROWSER="firefox"
EOF

source "${I3_ZSH_PATH}"

