#!/bin/bash

set -e

PREFIX='/usr/local'
TMPDIR=$(mktemp -d)

# Install required dependencies.
sudo apt install -y cmake gzip pkg-config libfreetype-dev libfontconfig-dev libxcb-xfixes0-dev libxkbcommon-dev python3 scdoc

# Clone/build Alacritty.
git clone https://github.com/alacritty/alacritty "$TMPDIR" && cd "$TMPDIR" && cargo build --release

# Install Alacritty.
sudo cp target/release/alacritty "$PREFIX/bin"

# Install terminfo file.
infocmp >/dev/null 2>&1 || sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

# Install desktop entry.
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# Install man pages.
sudo mkdir -p "$PREFIX/share/man/man1"
sudo mkdir -p "$PREFIX/share/man/man5"

scdoc < extra/man/alacritty.1.scd          | gzip -c | sudo tee "$PREFIX/share/man/man1/alacritty.1.gz"          > /dev/null
scdoc < extra/man/alacritty-msg.1.scd      | gzip -c | sudo tee "$PREFIX/share/man/man1/alacritty-msg.1.gz"      > /dev/null
scdoc < extra/man/alacritty.5.scd          | gzip -c | sudo tee "$PREFIX/share/man/man5/alacritty.5.gz"          > /dev/null
scdoc < extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee "$PREFIX/share/man/man5/alacritty-bindings.5.gz" > /dev/null

# Install shell completions.
sudo mkdir -p "$PREFIX/share/alacritty"
sudo cp -r extra/completions "$PREFIX/share/alacritty"

# Clean up.
rm -rf "$TMPDIR"
