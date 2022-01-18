#!/usr/bin/env sh

# This is stupid

set -x

ALACRITTY_CONFIG="$HOME/.config/alacritty/alacritty.yml"

LIGHT="colors: *light"
DARK="colors: *dark"

function sed_escape() {
  echo "$1" | sed -e 's/[]\/$*.^[]/\\&/g'
}

function replace() {
  sed -i '' -e "s/$(sed_escape "$1")/$(sed_escape "$2")/g" "$ALACRITTY_CONFIG"
}

if grep -Fq "$LIGHT" "$ALACRITTY_CONFIG"; then
  replace "$LIGHT" "$DARK"
else
  replace "$DARK" "$LIGHT"
fi
