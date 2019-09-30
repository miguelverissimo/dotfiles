# Path to your oh-my-zsh installation.
export ZSH=/Users/miguel/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# ZSH_THEME="cobalt2"
ZSH_THEME="spaceship"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.dotfiles/zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man colorize github python brew osx zsh-syntax-highlighting golang fasd)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

DEFAULT_USER="Miguel"
$(prompt_context(){})

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# source all the zsh files

# z!!!
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
for config_file ($HOME/.dotfiles/zsh/*.zsh) source $config_file
