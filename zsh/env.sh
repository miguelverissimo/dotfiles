# ~/.dotfiles/zsh/env.sh -- environment shared by every shell (zsh and bash,
# login or not, interactive or not: ssh nuc 'cmd', scp, rsync, agents).
# Sourced from ~/.zshenv and ~/.bashrc. POSIX sh only. Must stay quiet and
# fast, and must not fail when a file is missing.

_df="$HOME/.dotfiles"

# Omarchy: OMARCHY_PATH, appends mise shims + ~/.local/bin to PATH.
[ -r /usr/share/omarchy/default/bash/env-bootstrap ] && . /usr/share/omarchy/default/bash/env-bootstrap

### Editors / pager / language ###
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
[ -z "$LANG" ] && export LANG='en_US.UTF-8'
case "$OSTYPE" in darwin*) export BROWSER='open' ;; esac

### Less ###
export LESS='-F -g -i -M -R -S -w -X -z-4'
if command -v lesspipe.sh >/dev/null 2>&1; then
  export LESSOPEN="| /usr/bin/env lesspipe.sh %s 2>&-"
elif command -v lesspipe >/dev/null 2>&1; then
  export LESSOPEN="| /usr/bin/env lesspipe %s 2>&-"
fi

### X11 / Wayland (Wayland block: runbook Phase 5) ###
export XAUTHORITY="$HOME/.Xauthority"
if [ -z "$WAYLAND_DISPLAY" ] && [ -S /run/user/1000/wayland-1 ]; then
  export XDG_RUNTIME_DIR=/run/user/1000 WAYLAND_DISPLAY=wayland-1
fi

### Dotfiles env modules (PATH, API keys, Go, Erlang) ###
for _m in paths api-keys go elixir; do
  [ -r "$_df/modules/$_m.module" ] && . "$_df/modules/$_m.module"
done

### Tokens (old ~/.zprofile) ###
[ -r "$HOME/.super_secret" ] && . "$HOME/.super_secret"

### pnpm / opencode (were in ~/.zshrc) ###
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in *":$PNPM_HOME:"*) ;; *) PATH="$PNPM_HOME:$PATH" ;; esac
[ -d "$HOME/.opencode/bin" ] && PATH="$HOME/.opencode/bin:$PATH"

### Encore devdash on all interfaces (also set in dev-shenenigans.module) ###
export ENCORE_DEVDASH_LISTEN_ADDR=0.0.0.0:9400

### mise shims first, so mise-managed tools beat /usr/bin copies
### (e.g. herdr 0.9.5 from mise over the pacman herdr 0.9.1).
### Interactive zsh additionally runs `mise activate` in ~/.zshrc.
PATH="$HOME/.local/share/mise/shims:$PATH"
export PATH

unset _df _m
