#!/usr/bin/env bash

p () {
  echo "**** pacman installing $@ ****"
  sudo pacman -Syu --needed "$@"
  echo "-------------------------------------------------"
}

y () {
  echo "**** yaourt installing $@ ****"
  yay --nocleanmenu --nodiffmenu -Syu --needed "$@"
  echo "-------------------------------------------------"
}

### install core dependencies
echo "**** installing needed dependencies for yaourt ****"
p base-devel git wget yajl
echo "-------------------------------------------------"

### install yaourt
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
echo "**** installing base packages ****"
base_packages=" alacritty \
                bash-completion \
                bat \
                curl \
                dmenu \
                docker \
                docker-compose \
                docker-machine \
                emacs \
                exa \
                fasd \
                feh \
                fop \
                glances \
                httpie \
                i3-gaps \
                jq \
                jre-openjdk \
                keychain \
                lastpass-cli \
                libxml2 \
                libyaml \
                neovim \
                openssl \
                polybar \
                pyxdg \
                qtile \
                ranger \
                readline \
                redshift \
                ripgrep \
                scrot \
                snapd \
                the_silver_searcher \
                tig \
                tldr \
                tmate \
                tmux \
                unzip \
                vifm \
                xclip \
                xsel \
                zathura \
                zsh \
                zsh-autosuggestions"
aur_packages="  autojump \
                cheat \
                diff-so-fancy-git \
                direnv \
                dmenu \
                dockly \
                gotop \
                insomnia \
                nerd-fonts-cascadia-code  \
                nerd-fonts-fantasque-sans-mono  \
                nerd-fonts-fira-code  \
                nerd-fonts-hack  \
                nerd-fonts-iosevka  \
                nerd-fonts-jetbrains-mono  \
                nerd-fonts-victor-mono \
                picom \
                universal-ctags \
                zoom"
p $base_packages
y $aur_packages

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
echo "**** asdf installing python ****"
asdf plugin-add python
asdf install python 3.6.2
asdf install python 2.7.13
asdf global python 3.6.2 2.7.13
echo "-------------------------------------------------"

### node / npm
echo "**** asdf installing node ****"
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdf install nodejs 14.5.0
asdf global nodejs 14.5.0
echo "-------------------------------------------------"

### yarn
echo "**** asdf installing yarn ****"
asdf plugin-add yarn
asdf install yarn 1.22.4
asdf global yarn 1.22.4
echo "-------------------------------------------------"

### ruby
echo "**** asdf installing ruby ****"
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby 2.7.0
asdf install ruby 2.6.6
asdf global ruby 2.7.0 2.6.6
echo "-------------------------------------------------"

### rust
echo "**** asdf installing rust ****"
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf install rust 1.45.0
asdf global rust 1.45.0
echo "-------------------------------------------------"

### nvim integrations / nvim configs
echo "**** installing nvim and tooling ****"
python3 -m pip install --upgrade pip
python2 -m pip install --upgrade pip
pushd $HOME/.config
  echo "**** git installing nvim distro ****"
  git clone git@gitlab.com:miguelverissimo/nvim.git
popd
yarn global add neovim
gem install neovim
gem install solargraph
python2 install -m pip install --user --upgrade pynvim
python3 install -m pip install --user --upgrade pynvim
echo "-------------------------------------------------"

### doom-emacs
echo "**** git installing doom-emacs ****"
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
echo "-------------------------------------------------"

# other stuff
pip install psutil

# make zsh the default shell
chsh -s /usr/bin/zsh

### DONE!
echo "\n\nAll done installing packages!\n\n"
