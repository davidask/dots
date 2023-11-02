set fish_greeting

function fish_user_key_bindings
  fish_hybrid_key_bindings
  fzf_key_bindings
end

if test (uname) = "Darwin"

  alias tdm "$HOME/.dotfiles/toggle-darkmode.sh"

  if test (uname -m) = "arm64"
    set -gx PATH /opt/homebrew/bin $PATH
    set -gx PATH /opt/homebrew/opt/llvm/bin $PATH
    set -gx PATH /opt/homebrew/opt/openjdk/bin $PATH
  end
end

fish_add_path "$HOME/.cargo/bin"

alias dotfiles "cd ~/.dotfiles && nvim"

set -gx GOENV_ROOT "$HOME/.goenv"
fish_add_path "$GOENV_ROOT/bin"
goenv init - | source

fnm env --use-on-cd | source
starship init fish | source
