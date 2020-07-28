#!/usr/bin/env bash

set -e

# install all dependencies
# ./deps_install.sh

# configure all the apps
pushd ..
  ./install.sh
popd

# symlink modules
source ../_setup_scripts/backup_and_symlink
pushd modules
  CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
  for CONFIG_FILE in *.module; do
    ORIGIN="${CONFIGS_DIR}/${CONFIG_FILE}"
    DEST="${HOME}/.dotfiles/modules/${CONFIG_FILE}"
    backup_and_symlink ${ORIGIN} ${DEST}
  done
popd

# make keys go vrrroooooom
./remap_keyboard.sh

# setup arch specific software
echo "Setup all arch software"

CONFIGURATION_DIRS="i3 \
                    qtile"

for CONFIGURATION in ${CONFIGURATION_DIRS}; do
  pushd ${CONFIGURATION}
    echo "### Configuring ${CONFIGURATION} ###"
    ./setup.sh
    echo "### Finished configuring ${CONFIGURATION} ###"
  popd
done
