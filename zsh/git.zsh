alias g="git"
alias gap="git add -p"
alias gb="git branch -a -v"
alias gtb="git branch -u origin/" #track branch
alias gcm="git commit -v -m"
alias gcam="git commit -v -a -m"
alias gd="git diff -w"
alias gl="git pull"
alias glr="git pull --rebase"
alias gp="git push"
alias gs="git status"
alias gss="git status -sb"
alias gg="git tree"
alias ggs="gg --stat"
alias gsl="git shortlog -sn"
alias glg="git log --pretty=oneline --abbrev-commit"
alias gw="git whatchanged"
alias gsu="git submodule update --init --recursive"
alias uncommit="git reset --soft 'HEAD^'"
alias gchurn="git log --pretty="format:" --name-only | grep -vE '^(vendor/|$)' | sort | uniq -c | sort"
alias gpa="git remote | xargs -L1 -I R git push R"
alias gsw="git switch"

# track all remote branches
#alias gtab="git branch -a | grep -v HEAD | perl -ne 'chomp($_); s|^\*?\s*||; if (m|(.+)/(.+)| && not $d{$2}) {print qq(git branch --track $2 $1/$2\n)} else {$d{$_}=1}' | csh -xfs"
#alias gtab="for remote in `git branch -r `; do git branch --track $remote; done"
#alias gtabp="for remote in `git branch -r `; do git checkout $remote ; git pull; done"

# Useful report of what has been committed locally but not yet pushed to another
# branch.  Defaults to the remote origin/master.  The u is supposed to stand for
# undone, unpushed, or something.
function gu {
  local branch=$1
  if [ -z "$1" ]; then
    branch=master
  fi
  if [[ ! "$branch" =~ "/" ]]; then
    branch=origin/$branch
  fi
  local cmd="git cherry -v $branch"
  echo $cmd
  $cmd
}

function gco {
  if [ -z "$1" ]; then
    git switch master
  else
    git switch $*
  fi
}

function st {
  if [ -d ".svn" ]; then
    svn status
  else
    git status
  fi
}
