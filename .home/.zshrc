# =========================================
# === Enable plugins and init oh-my-zsh ===
# =========================================
# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
ZSH_THEME=""

plugins=(git zaw zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# =================
# === Key Binds ===
# =================
# CTRL-R will pull up zaw-history (backwards zsh history search)
bindkey '^r' zaw-history
# CTRL-B will pull up zaw-git-branches which will search your current git branches and switch (git checkout) to the branch you select when you hit enter.
bindkey '^b' zaw-git-branches

# =======================
# === Load Alias File ===
# =======================
if [ -f ~/.aliasrc ]; then
  source ~/.aliasrc
fi

# ==================
# === Setup PATH ===
# ==================
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/go/bin"

# ===================================
# === Setup Application specifics ===
# ===================================
export EDITOR="/usr/bin/nano"                          # default editor

eval "$(starship init zsh)"

# SSH Agent
eval `keychain --eval id_ed25519`
