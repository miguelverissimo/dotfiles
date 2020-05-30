#!/usr/bin/env bash

set -e
CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

for CONFIG_FILE in gemrc rcdebugrc ruby-version; do
  if [ -L ${HOME}/.${CONFIG_FILE} ]; then
    echo "Removing current symlink @${HOME}/.${CONFIG_FILE}"
    rm ${HOME}/.${CONFIG_FILE}
  fi

  if [ -f ${HOME}/.${CONFIG_FILE} ]; then
    echo "Backing current ${HOME}/.${CONFIG_FILE} to ${HOME}/.${CONFIG_FILE}.prev"
    \cp -rf ${HOME}/.${CONFIG_FILE}{,.prev}
    rm ${HOME}/.${CONFIG_FILE}
  fi

  echo "creating ${HOME}/.${CONFIG_FILE} symlinked to ${CONFIGS_DIR}/${CONFIG_FILE}"
  ln -s ${CONFIGS_DIR}/${CONFIG_FILE} ${HOME}/.${CONFIG_FILE}
done


# BUNDLER CONFIG
BUNDLER_CONFIG_DIR="${HOME}/.bundler"
BUNDLER_CONFIG_FILENAME_ORIGIN="bundler_config"
BUNDLER_CONFIG_FILENAME_DESTINY="config"

if [ ! -d ${BUNDLER_CONFIG_DIR} ]; then mkdir ${BUNDLER_CONFIG_DIR}; fi

if [ -L ${BUNDLER_CONFIG_DIR}/${BUNDLER_CONFIG_FILENAME_DESTINY} ]; then
  echo "removing current symlink @ ${BUNDLER_CONFIG_DIR}/${BUNDLER_CONFIG_FILENAME_DESTINY}"
  rm ${BUNDLER_CONFIG_DIR}/${BUNDLER_CONFIG_FILENAME_DESTINY}
fi

if [ -f ${BUNDLER_CONFIG_DIR}/${BUNDLER_CONFIG_FILENAME_DESTINY} ]; then
  echo "Backing current bundler ${BUNDLER_CONFIG_FILENAME_DESTINY} to ${BUNDLER_CONFIG_FILENAME_DESTINY}.prev"
  \cp -rf ${BUNDLER_CONFIG_DIR}/${BUNDLER_CONFIG_FILENAME_DESTINY}{,.prev}
  rm ${BUNDLER_CONFIG_DIR}/${BUNDLER_CONFIG_FILENAME_DESTINY}
fi

echo "symlinking ${CONFIGS_DIR}/${BUNDLER_CONFIG_FILENAME_ORIGIN} to ${BUNDLER_CONFIG_DIR}/${BUNDLER_CONFIG_FILENAME_DESTINY}"
ln -s ${CONFIGS_DIR}/${BUNDLER_CONFIG_FILENAME_ORIGIN} ${BUNDLER_CONFIG_DIR}/${BUNDLER_CONFIG_FILENAME_DESTINY}
