#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

echo "install TPM for tmux plugins"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
ORIGIN="${CONFIGS_DIR}/tmux.conf"
DEST="${HOME}/.tmux.conf"

backup_and_symlink ${ORIGIN} ${DEST}
