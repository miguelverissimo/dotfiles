#!/usr/bin/env bash

set -e
CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

echo "creating ${HOME}/.config/nvim/user symlinked to ${CONFIGS_DIR}"
ln -s ${CONFIGS_DIR} ${HOME}/.config/nvim/user
