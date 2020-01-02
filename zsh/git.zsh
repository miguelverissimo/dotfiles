# Git related
alias g="git"
alias gaa="git add -A"
alias gap="git add -p"
alias gb="git branch -a -v"
alias gtb="git branch -u origin/" #track branch 
alias gcm="git commit -v -m"
alias gcam="git commit -v -a -m"
alias gd="git diff -w"
alias gl="git pull"
alias glr="git pull --rebase"
alias gp="git push"
alias gpa="git pull --all"
alias gs="git status -sb"
alias gg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci)%Creset' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gsl="git shortlog -sn"
alias glg="git log --pretty=oneline --abbrev-commit"
alias gw="git whatchanged"
alias gsr="git svn rebase"
alias gsp="git svn dcommit"
alias gsu="git submodule update --init --recursive"
alias gi="git config branch.master.remote 'origin'; git config branch.master.merge 'refs/heads/master'"
alias uncommit="git reset --soft 'HEAD^'"
alias git-churn="git log --pretty="format:" --name-only | grep -vE '^(vendor/|$)' | sort | uniq -c | sort"

# track all remote branches
#alias gtab="git branch -a | grep -v HEAD | perl -ne 'chomp($_); s|^\*?\s*||; if (m|(.+)/(.+)| && not $d{$2}) {print qq(git branch --track $2 $1/$2\n)} else {$d{$_}=1}' | csh -xfs"
#alias gtab="for remote in `git branch -r `; do git branch --track $remote; done"
#alias gtabp="for remote in `git branch -r `; do git checkout $remote ; git pull; done"

# Useful report of what has been committed locally but not yet pushed to another
# # branch.  Defaults to the remote origin/master.  The u is supposed to stand for
# # undone, unpushed, or something.
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
    git checkout master
  else
    git checkout $*
  fi
}

function st {
  if [ -d ".svn" ]; then
    svn status
  else
    git status
  fi
}
