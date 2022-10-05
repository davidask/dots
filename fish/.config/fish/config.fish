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

set -gx PATH "$HOME/.cargo/bin" $PATH;

alias dotfiles "cd ~/.dotfiles && nvim"
alias g git

fnm env --use-on-cd | source
starship init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
