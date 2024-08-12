#!/usr/bin/env sh

# This is stupid
ALACRITTY_CONFIG="$HOME/.config/alacritty/alacritty.toml"

LIGHT="~/.config/alacritty/themes/light.toml"
DARK="~/.config/alacritty/themes/dark.toml"

sed_escape() {
  echo "$1" | sed -e 's/[]\/$*.^[]/\\&/g'
}

replace() {
  sed -i '' -e "s/$(sed_escape "$1")/$(sed_escape "$2")/g" "$ALACRITTY_CONFIG"
}

if grep -Fq "$LIGHT" "$ALACRITTY_CONFIG"; then
  replace "$LIGHT" "$DARK"
  osascript -e "tell app \"System Events\" to tell appearance preferences to set dark mode to true"
else
  osascript -e "tell app \"System Events\" to tell appearance preferences to set dark mode to false"
  replace "$DARK" "$LIGHT"
fi

# Reload
touch ~/.config/alacritty/alacritty.toml
