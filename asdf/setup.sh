#!/usr/bin/env bash

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

for CONFIG_FILE in tool-versions asdfrc; do
  ORIGIN="${CONFIGS_DIR}/${CONFIG_FILE}"
  DEST="${HOME}/.${CONFIG_FILE}"

  backup_and_symlink ${ORIGIN} ${DEST}
done


# source asdf and make it available in the shell
# via git installation, and this will make asdf.sh
# available in ~/.asdf/asdf.sh; otherwise install it
ASDF_PATH="\${HOME}/.asdf/asdf.sh"
ASDF_COMPLETIONS_PATH="\${HOME}/.asdf/completions/asdf.bash"

if [[ ! -f "${ASDF_PATH}" ]]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8
fi

ASDF_ZSH_PATH="${HOME}/.dotfiles/zsh/asdf.zsh"

cat << EOF > "${ASDF_ZSH_PATH}"
export ASDF_RUBY_BUILD_VERSION=master
source $ASDF_PATH
source $ASDF_COMPLETIONS_PATH
EOF

source "${ASDF_ZSH_PATH}"

# install all asdf language plugins
echo "installing asdf language plugins"

# pgp signatures are necessary for node
gpgconf --kill all
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add yarn
asdf plugin-add python
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git

# install configured versions
echo "installing languages"
cd $HOME
asdf install
cd -
