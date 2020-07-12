#!/usr/bin/env bash

set -e

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
TMUX_CONFIG_FILE="${HOME}/.tmux.conf"

if [ -L ${TMUX_CONFIG_FILE} ]; then
  echo "removing current symlink @ ${TMUX_CONFIG_FILE}"
  rm ${TMUX_CONFIG_FILE}
fi

if [ -f ${TMUX_CONFIG_FILE} ]; then
  echo "Backing up current settings to ${TMUX_CONFIG_FILE}.prev"
  \cp -rf ${TMUX_CONFIG_FILE}{,.prev}
  rm ${TMUX_CONFIG_FILE}
fi

echo "creating ${TMUX_CONFIG_FILE} symlinked to ${CONFIGS_DIR}/tmux.conf"
ln -s ${CONFIGS_DIR}/tmux.conf ${TMUX_CONFIG_FILE}
