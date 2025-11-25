#!/bin/bash

# vi: ts=4 sw=4 et

set -Eeuo pipefail

#
# Install some utilities for a nicer dev environment.
#
# Use yay instead of pacman to avoid having to enter a password if everything is already installed.
#
yay --noconfirm --needed -S \
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

# Ensure files are installed to the correct location.
. .zshenv

# Install dotfiles.
mkdir -p "$XDG_CONFIG_HOME"
ln -s .dotfiles/.zshenv $HOME/.zshenv
for f in .config/*; do
    [ -e "$HOME/$f" ] && mv "$HOME/$f" "$HOME/$f.bak"
    ln -s "../.dotfiles/$f" "$HOME/$f"
done

# Download Tmux plugins with the Tmux Plugin Manager.
git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
$XDG_CONFIG_HOME/tmux/plugins/tpm/bin/install_plugins
