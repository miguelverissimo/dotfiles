function print_disclaimer {
  printf "******************* Dotfiles installer & system setup *******************\n"
  printf "*                                                                       *\n"
  printf "* By Miguel Verissimo, based on yadr, Luan's mvim and bosh-workstation. *\n"
  printf "* Many thanks to all the contributors to these projects.                *\n"
  printf "*                                                                       *\n"
  printf "* This script will install homebrew, a bunch of base software, zsh,     *\n"
  printf "* prezto, macvim and all dotfiles. Read the script and rakefile before  *\n"
  printf "* executing and execute at your own risk. Some operations are           *\n"
  printf "* destructive and your dotfiles might be clobbered in the process.      *\n"
  printf "*                                                                       *\n"
  printf "************************* | HERE BE DRAGONS | ***************************\n"
  printf "                          V                 V\n\n"
}

function ensure_homebrew {
  printf "making sure homebrew is installed... "

  if ! [ -x "$(command -v brew)" ]; then
    printf "not installed... Installing now\n"
    mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
  else
    printf "ok.\n"
  fi
}

function ensure_ruby_install {
  printf "making sure ruby-install is installed... "

  if ! `brew list ruby-install > /dev/null`; then
    printf "not installed... Installing now\n"
    brew install ruby-install
  else
    printf "ok.\n"
  fi
}

function ensure_chruby {
  printf "making sure chruby is installed... "

  if ! [ -a /usr/local/share/chruby/chruby.sh ]; then
    printf "not installed... Installing now\n"
    brew install chruby
  else
    printf "ok.\n"
  fi
}

function ensure_ruby_version {
  ruby_version=`cat ./ruby/ruby-version`
  printf "making sure ${ruby_version} is installed... "

  if [ -z "`source /usr/local/share/chruby/chruby.sh && chruby | grep ${ruby_version}`" ]; then
    printf "not installed... Installing now\n"
    install-ruby ${ruby_version}
  else
    printf "ok.\n"
  fi
  source /usr/local/share/chruby/chruby.sh && chruby ${ruby_version}
}

function ensure_tty_gem {
  printf "making sure tty gem is installed... "

  if [ -z "$(gem list | grep tty)" ]; then
    printf "not installed... Installing now\n"
    gem install tty
  else
    printf "ok.\n"
  fi
}

function run_rake_task {
  task="$1"
  ask="$2"

  if [ -z $ask ]; then
    ask=$task
    task="full_installation"
    printf "Running full installation"
  else
    printf "Running task $task"
  fi

  if [[ "$ask" = "--ask" ]] || [[ "$ask" = "-a" ]]; then
    printf " with confirmation before each step\n"
    ASK=true rake "$task"
  else
    printf "\n"
    rake "$task"
  fi
}

function display_help_if_requested {
  if [[ "$1" = "-h" ]] || [[ "$1" = "--help" ]]; then
    printf "Usage: install.sh [-h | --help | TASK] [-a | --ask]\n"
    printf "       - Running without parameters will run all the tasks without confirmation.\n"
    printf "       - Running with --ask or -a will ask for confirmation before running each task.\n\n"
    printf "         -h, --help  # display this message\n"
    printf "         TASK        # execute a specific task from the following:\n"
    rake -T | sed -e 's/rake/         - /g'
    exit 0
  fi

  printf "\nPreparing to run task ${1}\n"
  printf "Verifying prerequisites.\n"
}

display_help_if_requested "$1"
print_disclaimer
ensure_homebrew
ensure_ruby_install
ensure_chruby
ensure_ruby_version
ensure_tty_gem
run_rake_task "$@"
