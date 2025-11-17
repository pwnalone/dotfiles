#!/bin/bash

# vi: ts=4 sts=4 sw=4 et

set -Eeuo pipefail

# Install some utilities for a nicer dev environment.
sudo pacman --noconfirm --needed -S \
    alacritty \
    bat \
    fd \
    fzf \
    gdb \
    git \
    lazygit \
    lsd \
    nerd-fonts \
    ripgrep \
    rizin \
    starship \
    tmux \
    zsh

# Ensure these directories are in our PATH for later.
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Ensure files are installed to the correct location.
. ./.zshenv

# Install dotfiles.
mkdir -p "$XDG_CONFIG_HOME"
ln -s .dotfiles/.zshenv $HOME/.zshenv
for f in .config/*; do
    [ -e "$HOME/$f" ] && mv "$HOME/$f" "$HOME/$f.bak"
    ln -s "../.dotfiles/$f" "$HOME/$f"
done

# Add NerdFont symbols to the Starship configuration.
cp $XDG_CONFIG_HOME/starship/starship.toml.in $XDG_CONFIG_HOME/starship/starship.toml
starship preset nerd-font-symbols >>$XDG_CONFIG_HOME/starship/starship.toml
