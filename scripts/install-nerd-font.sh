#!/bin/bash

set -e

XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

FONTNAME="${1:-Hermit}"
FONTPATH="$XDG_DATA_HOME/fonts/$FONTNAME"
wget "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$FONTNAME.zip"
mkdir -p "$FONTPATH" && unzip -d "$FONTPATH" "$FONTNAME.zip" && rm -f "$FONTNAME.zip"
fc-cache -fv
