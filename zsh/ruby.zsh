# Get rid of the pesky deprecation warnings since ruby 2.7.0
export RUBYOPT='-W:no-deprecated -W:no-experimental'

# Ruby and Rails related
alias b="bundle"
alias bu="bundle update"
alias be="bundle exec"

# Hanami
alias ha="bundle exec hanami"
alias hag="bundle exec hanami generate"
alias has="bundle exec hanami server"
alias hat="HANAMI_ENV=test bundle exec hanami"
alias hart="bundle exec rake"
