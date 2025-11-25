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
    binutils \
    bridge-utils \
    checksec \
    clang \
    cmake \
    curl \
    diffutils \
    distrobox \
    dog \
    duf \
    fastfetch \
    fd \
    findutils \
    flatpak \
    fzf \
    gcc \
    gdb \
    git \
    gptfdisk \
    htop \
    imagemagick \
    inetutils \
    iproute2 \
    iputils \
    iw \
    jq \
    lazygit \
    ldns \
    less \
    lsd \
    ltrace \
    make \
    man-db \
    man-pages \
    meson \
    moreutils \
    ncdu \
    neovim \
    nerd-fonts \
    net-tools \
    node \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    noto-fonts-extra \
    npm \
    openbsd-netcat \
    openssh \
    pacman-contrib \
    pciutils \
    plocate \
    podman \
    pwndbg \
    ripgrep \
    rizin \
    ropper \
    socat \
    starship \
    strace \
    tcpdump \
    tectonic \
    tmux \
    tokei \
    tree \
    tree-sitter-cli \
    unzip \
    usbutils \
    vim \
    wget \
    which \
    wireguard-tools \
    wl-clipboard \
    yt-dlp \
    zip \
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
