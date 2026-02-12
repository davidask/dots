#!/usr/bin/env zsh

bindkey -v
bindkey '^f' autosuggest-accept
# https://github.com/spaceship-prompt/spaceship-prompt/issues/91#issuecomment-327996599
bindkey "^?" backward-delete-char

zstyle ':zim:zmodule' use 'degit'

ZIM_HOME=~/.zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

export PATH="$HOME/.dbt/bin:$PATH"
export PATH="$HOME/.dotfiles/bin:$PATH"

alias dotfiles="cd ~/.dotfiles && nvim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"

eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"


# bun completions
[ -s "/Users/davidask/.bun/_bun" ] && source "/Users/davidask/.bun/_bun"

# pnpm
export PNPM_HOME="/Users/davidask/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$HOME/.dbt/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
