alias galias="cat $HOME/.dotfiles/zsh/git.zsh"
alias galg="galias | ag"
alias g="git"
alias gap="git add -p" # add interactively
alias gb="git branch -a -v" # show branches (local and remote) with commit information
alias gtb="git branch -u" # track branch
alias gcm="git commit -m" # commit with message
alias gcam="git commit -a -m" # add all and commit with message
alias gd="git diff -w" # diff ignoring whitespace
alias gp="git pull"
alias gpr="git pull --rebase" # pull with rebase
alias gpu="git push"
alias gpa="git remote | xargs -L1 -I R git push R" # push to all remotes
alias gpauc="gpa -u $(git branch --show-current)" # track and push current branch to all remotes
alias gpac="gpa $(git branch --show-current)" # push current branch to all remotes
alias gs="git status"
alias gst="git status"
alias gss="git status -sb" # short status with branch information
alias gg="git tree" # show the history visually in a tree format
alias ggs="gg --stat" # show the history visually in a tree format, with information on the files changed
alias gsl="git shortlog -sn"
alias glg="git log --pretty=oneline --abbrev-commit" # terse (compact) history, with short shas
alias gw="git whatchanged" # long history, with author, commit message and files
alias gsu="git submodule update --init --recursive" # initialize all submodules
alias uncommit="git reset --soft 'HEAD^'" # undo the last commit
alias gchurn="git log --pretty="format:" --name-only | grep -vE '^(vendor/|$)' | sort | uniq -c | sort"
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
