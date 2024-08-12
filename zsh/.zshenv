
if [[ "$(uname)" == "Darwin" ]]; then
  alias tdm="$HOME/.dotfiles/toggle-darkmode.sh"

  if [[ "$(uname -m)" == "arm64" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/sbin:$PATH"
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
  fi

  export PATH="$HOME/.cargo/bin:$PATH"
fi
