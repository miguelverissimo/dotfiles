#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

# Run the dependencies install script first
./_dependencies/setup.sh

