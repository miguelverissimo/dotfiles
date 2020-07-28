#!/usr/bin/env bash

p () {
  echo "**** pacman installing $@ ****"
  yes | sudo pacman -Syu "$@"
  echo "-------------------------------------------------"
}

y () {
  echo "**** yaourt installing $@ ****"
  yay -S "$@"
  echo "-------------------------------------------------"
}

ymanual () {
  echo "**** yaourt installing $@ ****"
  yay "$@"
  echo "-------------------------------------------------"
}

### install yaourt
p --needed base-devel
p git
p wget
p yajl
echo "**** git installing yaourt ****"
pushd /tmp/
  git clone https://aur.archlinux.org/package-query.git
  pushd package-query/
    yes | makepkg -si
    git clone https://aur.archlinux.org/yaourt.git
    pushd yaourt/
      yes | makepkg -si
    popd
  popd
popd
echo "-------------------------------------------------"

echo "**** git installing yay ****"
pushd /tmp/
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
popd
echo "-------------------------------------------------"

### all base packages
p zsh
p zsh-autosuggestions
p curl
p bash-completion
p snapd
p jq
p libxml2
p libyaml
p fasd
p jre-openjdk
p fop
p openssl
p readline
p ripgrep
p the_silver_searcher
p tig
p tmux
p xclip
p xsel
p unzip
p lastpass-cli
p ranger
p vifm
p zxiv

### windows managers
p i3-gaps
p i3status-rust
p qtile

### alacritty
p alacritty

### docker / docker-compose / docker-machine
p docker
p docker-compose
p docker-machine

### nix
echo "**** installing nixos ****"
curl -L https://nixos.org/nix/install | sh
echo "-------------------------------------------------"

### asdf
echo "**** git installing asdf ****"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8
source $HOME/.asdf/asdf.sh
echo "-------------------------------------------------"

### python 2 & 3
echo "**** asdf installing python plugin ****"
asdf plugin-add python
echo "-------------------------------------------------"

### node / npm
echo "**** asdf installing node plugin ****"
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
echo "-------------------------------------------------"

### yarn
echo "**** asdf installing yarn plugin ****"
asdf plugin-add yarn
echo "-------------------------------------------------"

### ruby
echo "**** asdf installing ruby plugin ****"
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
echo "-------------------------------------------------"

### rust
echo "**** asdf installing rust plugin ****"
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
echo "-------------------------------------------------"

### install required languages
echo "**** asdf installing languages ****"
cat << EOF > ${HOME}/.tool-versions
python 3.6.2 2.7.13
nodejs 14.5.0
yarn 1.22.4
ruby 2.7.0 2.6.6
rust 1.45.0
EOF
pushd $HOME
  asdf install
popd
echo "-------------------------------------------------"

### nvim / nvim helpers / nvim configs
python3 -m pip install --upgrade pip
python2 -m pip install --upgrade pip
p neovim
pushd $HOME/.config
  echo "**** git installing asdf ****"
  git clone git@gitlab.com:miguelverissimo/nvim.git
popd
yarn global add neovim
gem install neovim
gem install solargraph
python2 install -m pip install --user --upgrade pynvim
python3 install -m pip install --user --upgrade pynvim
echo "-------------------------------------------------"

### emacs + doom-emacs
p emacs
echo "**** git installing doom-emacs ****"
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
echo "-------------------------------------------------"

### universal ctags
y universal-ctags

# other stuff
y picom
y dmenu
y direnv
pip install psutil

# make zsh the default shell
chsh -s /bin/zsh

### DONE!
echo
echo
echo "All done!"
echo
echo
