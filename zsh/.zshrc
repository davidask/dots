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
fpath=(~/.grok/completions/zsh $fpath)
source ${ZIM_HOME}/init.zsh

# export PATH="$HOME/.dbt-env/bin:$PATH"
export PATH="$HOME/.dotfiles/bin:$PATH"

export EDITOR="hx"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"
if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi


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
export PATH="$HOME/.local/bin:$PATH"
# Added by dbt Fusion extension (ensure dbt binary dir on PATH)
if [[ ":$PATH:" != *":/Users/davidask/.local/bin:"* ]]; then
  export PATH=/Users/davidask/.local/bin:"$PATH"
fi
# Added by dbt Fusion extension
alias dbtf=/Users/davidask/.local/bin/dbt

# Automatically set THEME_MODE for OpenCode based on macOS appearance
if [[ "$(uname)" == "Darwin" ]]; then
  if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -qi '^Dark$'; then
    export THEME_MODE="dark"
  else
    export THEME_MODE="light"
  fi
fi

# Wrapper function to update active shell environment on toggle
sync-appearance() {
  command sync-appearance
  if [[ "$(uname)" == "Darwin" ]]; then
    if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -qi '^Dark$'; then
      export THEME_MODE="dark"
    else
      export THEME_MODE="light"
    fi
  fi
}
# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
# <<< grok installer <<<
