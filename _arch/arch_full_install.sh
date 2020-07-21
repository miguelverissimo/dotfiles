#!/usr/bin/env bash

set -e

./arch_deps_install.sh
pushd ..
./install.sh
popd
./remap_keyboard.sh

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
