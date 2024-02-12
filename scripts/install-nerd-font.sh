#!/bin/bash

set -e

FONTNAME="${1:-Hermit}"
FONTPATH="$XDG_DATA_HOME/fonts/$FONTNAME"
wget "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$FONTNAME.zip"
mkdir -p "$FONTPATH" && unzip -d "$FONTPATH" "$FONTNAME.zip" && rm -f "$FONTNAME.zip"
fc-cache -fv
