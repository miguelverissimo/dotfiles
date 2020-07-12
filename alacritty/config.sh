#!/usr/bin/env bash

set -e

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
ALACRITTY_CONFIG_DIR="${HOME}/.config/alacritty"
ALACRITTY_CONFIG_FILE_PATH="${ALACRITTY_CONFIG_DIR}/alacritty.yml"

if [ ! -d ${ALACRITTY_CONFIG_DIR} ]; then mkdir ${ALACRITTY_CONFIG_DIR}; fi

if [ -L ${ALACRITTY_CONFIG_FILE_PATH} ]; then
  echo "removing current symlink @ ${ALACRITTY_CONFIG_FILE_PATH}"
  rm ${ALACRITTY_CONFIG_FILE_PATH}
fi

if [ -f ${ALACRITTY_CONFIG_FILE_PATH} ]; then
  echo "Backing up current settings to ${ALACRITTY_CONFIG_FILE_PATH}.prev"
  \cp -rf ${ALACRITTY_CONFIG_FILE_PATH}{,.prev}
  rm ${ALACRITTY_CONFIG_FILE_PATH}
fi

echo "creating ${ALACRITTY_CONFIG_FILE_PATH} symlinked to ${CONFIGS_DIR}/alacritty.yml"
ln -s ${CONFIGS_DIR}/alacritty.yml ${ALACRITTY_CONFIG_FILE_PATH}
