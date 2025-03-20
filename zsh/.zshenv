
if [[ "$(uname)" == "Darwin" ]]; then
  alias tdm="$HOME/.dotfiles/toggle-darkmode.sh"
  alias killport='f() { kill $(lsof -t -i:$1) };f'

  if [[ "$(uname -m)" == "arm64" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/sbin:$PATH"
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
  fi

  export PATH="$HOME/.cargo/bin:$PATH"
fi
