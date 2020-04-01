# Rspec
alias pr='parallel_rspec'

# FASD
alias j='z'

# cf
alias cf-ruby="cf ssh -tt -c \"/tmp/lifecycle/launcher /home/vcap/app bash ''\""

# Story because too lazy to copy/paste
story() {
  if [[ "$1" == "--query" || "$1" == "-?" ]]; then
    cat ~/.gitmessage | tail -1
  elif [[ "$1" == "--clear" || "$1" == "-C" ]]; then
    echo -n >| ~/.gitmessage
    echo "Cleared out story number"
  elif [[ "$1" =~ ^#[0-9]+$ ]]; then
    story_id=${1#"#"}
    echo -e "\n\n[$1](https://www.pivotaltracker.com/story/show/${story_id})" >| ~/.gitmessage
    echo "Set story to ${story_id}"
  elif [[ "$1" =~ ^[0-9]+$ ]]; then
    echo -e "\n\n[#$1](https://www.pivotaltracker.com/story/show/$1)" >| ~/.gitmessage
    echo "Set story to #$1"
  elif [[ "$1" =~ ^https://.*$ ]]; then
    story_id=$(echo -n $1 | cut -d'/' -f6)
    echo -e "\n\n[#$story_id](https://www.pivotaltracker.com/story/show/$story_id)" >| ~/.gitmessage
    echo "Set story to #$story_id"
  else
    echo "usage: story [-h] [--clear|-C] [--query|-?] [story id]"
    echo -e "\t--query, -?:\tshows tracked story"
    echo -e "\t--clear, -C:\tunsets tracked story"
    echo -e "\t--help, -h:\thelp (this)"
    echo -e "\t[story id]:\tsets tracked story to [story id]"
  fi
}

