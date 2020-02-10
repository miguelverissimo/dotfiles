# Ruby and Rails related
alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"
alias dbmig="rake db:migrate db:test:clone"

# don't show deprecation warnings
export RUBYOPT=-W:no-deprecated
