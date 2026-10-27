# Template for modules/api-keys.module (git-ignored; holds the real values).
#
# Setup: create a 1Password item "dotfiles api-keys" in the Private vault with
# one concealed field per variable name below, then regenerate with:
#   op inject -i ~/.dotfiles/modules/api-keys.module.tpl -o ~/.dotfiles/modules/api-keys.module

export OPENROUTER_API_KEY="{{ op://Private/dotfiles api-keys/OPENROUTER_API_KEY }}"

# NEON
export NEON_AWS_ACCESS_KEY_ID="{{ op://Private/dotfiles api-keys/NEON_AWS_ACCESS_KEY_ID }}"
export NEON_AWS_SECRET_ACCESS_KEY="{{ op://Private/dotfiles api-keys/NEON_AWS_SECRET_ACCESS_KEY }}"
export JIRA_API_TOKEN="{{ op://Private/dotfiles api-keys/JIRA_API_TOKEN }}"
