#!/usr/bin/env bash

set -e
GIT_TEMPLATE_DIR=$(cd "$(dirname "$0")/git_template"; pwd)

git config --global init.templatedir $GIT_TEMPLATE_DIR

# ensure that we have a ~/.gitmessage file
touch ${HOME}/.gitmessage
