# need homebrew
# need ruby / rake
# need highline gem

# rake $1


function ensure_homebrew() {
  echo "making sure homebrew is installed..."

  if ! [ -x "$(command -v brew)" ]; then
    echo "not installed... Installing now"

  else
    echo "installed, continuing."
  fi
  echo
}

function ensure_ruby_install() {
  echo "making sure ruby-install is installed..."

  if ! `brew list ruby-install > /dev/null`; then
    echo "not installed... Installing now"
  else
    echo "installed, continuing."
  fi
  echo
}

function ensure_chruby() {
  echo "making sure chruby is installed..."

  if ! [ -a /usr/local/share/chruby/chruby.sh ]; then
    echo "not installed... Installing now"
  else
    echo "installed, continuing."
  fi
  echo
}

function ensure_ruby_version() {
  ruby_version=`cat ./ruby/ruby-version`
  echo "making sure ${ruby_version} is installed..."

  echo "`source /usr/local/share/chruby/chruby.sh && chruby | grep $ruby_version`"
  if [ -z `source /usr/local/share/chruby/chruby.sh && chruby | grep $ruby_version` ]; then
    echo "not installed... Installing now"
  else
    echo "installed, continuing."
  fi
  source /usr/local/share/chruby/chruby.sh && chruby $ruby_version
  echo
}

function ensure_highline_gem() {
  echo "making sure highline gem is installed..."

  if [ -z "$(gem list | grep highline)" ]; then
    echo "not installed... Installing now"
    gem install highline
  else
    echo "installed, continuing."
  fi
  echo
}

function run_rake_task() {
  echo "Running rake $1"
  echo
}

fn_exists() {
  [ `type -t $1`"" == 'function' ]
}

ensure_homebrew
ensure_ruby_install
ensure_chruby
ensure_ruby_version
ensure_highline_gem
run_rake_task
