#!/usr/bin/env bash

a () {
  echo "**** apt installing $@ ****"
  sudo apt install -y "$@"
  echo "-------------------------------------------------"
}

### PPAs
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update

### all base packages
echo "**** installing base packages ****"
base_packages=" aria2 \
                autoconf \
                autojump \
                automake \
                bash-completion \
                bat \
                build-essential \
                curl \
                direnv \
                docker \
                docker-compose \
                emacs \
                fasd \
                feh \
                fop \
                gdebi \
                git \
                httpie \
                jq \
                keychain \
                lastpass-cli \
                libncurses5-dev \
                libssl-dev \
                libreadline-dev \
                libxml2-dev \
                libxstl-dev \
                libyaml-0-2 \
                libz-dev \
                neovim \
                openjdk-14-jre \
                openssh-server \
                openssl \
                readline-common \
                ripgrep \
                silversearcher-ag \
                snapd \
                stterm \
                suckless-tools \
                terminology \
                tig \
                tldr \
                tmate \
                tmux \
                universal-ctags \
                unzip \
                vifm \
                wget \
                xclip \
                xsel \
                zsh \
                zsh-autosuggestions"
a $base_packages

# correct international keyboard
echo "**** installing international keyboard support ****"
sudo apt-add-repository -y ppa:rael-gc/utils
sudo apt update
a win-us-intl
gsettings set org.gnome.settings-daemon.plugins.xsettings disabled-gtk-modules '["'keyboard'"]'
im-config -n uim
echo "-------------------------------------------------"

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
asdf install ruby 3.0.0
asdf install ruby 2.6.6
asdf global ruby 3.0.0 2.6.6
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
python2 -m pip install --user --upgrade pynvim
python3 -m pip install --user --upgrade pynvim
echo "-------------------------------------------------"

# other stuff
echo "**** pip installing psutil ****"
pip install psutil
echo "-------------------------------------------------"

# make zsh the default shell
echo "**** changing shell to zsh ****"
chsh -s /usr/bin/zsh
echo "-------------------------------------------------"

echo "**** installing docker ****"
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker miguel
echo "-------------------------------------------------"

echo "**** installing exa ****"
https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
unzip exa-linux-x86_64-0.9.0.zip
sudo install exa-linux-x86_64 /usr/local/bin/exa
echo "-------------------------------------------------"

echo "**** installing diff-so-fancy ****"
git clone https://github.com/so-fancy/diff-so-fancy $HOME/.dotfiles/bin/diff-so-fancy
echo "-------------------------------------------------"

echo "**** installing ytop ****"
cargo install ytop
echo "-------------------------------------------------"

echo "**** installing alacritty ****"
pushd /tmp
  git clone https://github.com/jwilm/alacritty
  cargo install --path alacritty/
  sudo install alacitty/target/release/alacritty /usr/local/bin
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50
  echo "**** Select Alacritty ****"
  sudo update-alternatives --config x-terminal-emulator
popd
echo "-------------------------------------------------"

echo "**** installing lazygit ****"
sudo add-apt-repository ppa:lazygit-team/release
sudo apt-get update
sudo apt-get install lazygit
echo "-------------------------------------------------"

echo "**** installing gihub cli ****"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
a dirmngr gh
echo "-------------------------------------------------"

echo "**** installing gitlab cli ****"
pushd /tmp
  git clone https://github.com/profclems/glab.git
  cd glab
  make
  sudo install ./bin/glab /usr/local/bin/glab
popd
echo "-------------------------------------------------"

echo "**** installing fonts ****"
pushd /tmp
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FantasqueSansMono.zip
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/VictorMono.zip
  unzip -o CascadiaCode.zip -d ~/.fonts
  unzip -o FantasqueSansMono.zip -d ~/.fonts
  unzip -o FiraCode.zip -d ~/.fonts
  unzip -o Hack.zip -d ~/.fonts
  unzip -o Iosevka.zip -d ~/.fonts
  unzip -o JetBrainsMono.zip -d ~/.fonts
  unzip -o VictorMono.zip -d ~/.fonts
  fc-cache -fv
popd
echo "-------------------------------------------------"

echo "**** configuring editor ***"
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
echo "-------------------------------------------------"
### DONE!
echo "\n\nAll done installing packages!\n\n"
