# Story because too lazy to copy/paste
task() {
  if [[ "$1" == "--query" || "$1" == "-?" || "$1" == "-q" ]]; then
    cat ~/.gitmessage | tail -2
  elif [[ "$1" == "--clear" || "$1" == "-C" || "$1" == "-c" ]]; then
    echo -n >| ~/.gitmessage
    echo "Cleared out task number"
  elif [[ "$1" =~ ^#[0-9a-z]+$ ]]; then
    task_id=${1#"#"}
    printf '\n\n[#%s](https://app.clickup.com/t/%s)\n# [`#%s[done]`](https://app.clickup.com/t/%s)\n' $task_id $task_id $task_id $task_id >| ~/.gitmessage
    echo "Set task to ${task_id}"
  elif [[ "$1" =~ ^[0-9a-z]+$ ]]; then
    task_id="$1"
    printf '\n\n[#%s](https://app.clickup.com/t/%s)\n# [`#%s[done]`](https://app.clickup.com/t/%s)\n' $task_id $task_id $task_id $task_id >| ~/.gitmessage
    echo "Set task to #$task_id"
  elif [[ "$1" =~ ^https://.*$ ]]; then
    task_id=$(echo -n $1 | cut -d'/' -f5)
    printf '\n\n[#%s](https://app.clickup.com/t/%s)\n# [`#%s[done]`](https://app.clickup.com/t/%s)\n' $task_id $task_id $task_id $task_id >| ~/.gitmessage
    echo "Set task to #$task_id"
  else
    echo "usage: task [-h] [--clear|-c|-C] [--query|-q|-?] [task id]"
    echo -e "\t--query, -q, -?\t  shows tracked task"
    echo -e "\t--clear, -c, -C\t  unsets tracked task"
    echo -e "\t--help, -h\t  help (this)"
    echo -e "\t[task id]\t  sets tracked task to [task id]"
  fi
}

