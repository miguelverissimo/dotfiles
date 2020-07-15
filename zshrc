COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
  export VISUAL='nvim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

DEFAULT_USER="Miguel"

# source all individual configs and aliases
for config_file ($HOME/.dotfiles/zsh/*.zsh) source $config_file

# source fzf zsh integration
test -e "${HOME}/.fzf.zsh" && source "${HOME}/.fzf.zsh"

# source iterm2 zsh integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
