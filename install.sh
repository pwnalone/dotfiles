#!/bin/bash

# vi: ts=4 sw=4 et

set -Eeuo pipefail

THREADS=${THREADS:-$(nproc)}

NERD_FONTS_URI="https://github.com/ryanoasis/nerd-fonts"

# Specify "all" or an array of Nerd Fonts to install.
NERD_FONTS=(Hermit)

# Update the package list and perform a full upgrade.
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y

# Install some utilities for a nicer dev environment.
sudo apt install -y \
    alacritty \
    bat \
    binutils \
    cargo \
    checksec \
    clang \
    cmake \
    curl \
    diffutils \
    duf \
    fastfetch \
    fd-find \
    findutils \
    fonts-noto \
    fzf \
    gcc \
    gdb \
    gdisk \
    ghidra \
    git \
    htop \
    imagemagick \
    iproute2 \
    iw \
    jq \
    lazygit \
    less \
    lsd \
    ltrace \
    make \
    man-db \
    manpages \
    manpages-dev \
    meson \
    moreutils \
    ncdu \
    neovim \
    net-tools \
    nodejs \
    npm \
    openssh-client \
    openssh-server \
    pciutils \
    plocate \
    podman \
    ripgrep \
    rizin \
    rizin-cutter \
    ropper \
    rz-ghidra \
    socat \
    strace \
    tcpdump \
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

# Install the specified Nerd Fonts or all Nerd Fonts.
pushd $(mktemp -d)
if [ "$NERD_FONTS" = "all" ]; then
    #
    # WARN: This may fail when run from a tmpfs.
    #
    # If this occurs, set TMPDIR to a non-tmpfs directory and try again.
    #
    git clone --depth=1 $NERD_FONTS_URI . && ./install.sh -q
else
    C="curl -fsSL $NERD_FONTS_URI/releases/latest/download/{}.tar.xz | tar -Jx"
    parallel -j $THREADS -i sh -c "$C" -- "${NERD_FONTS[@]}"
    install -Dt $XDG_DATA_HOME/fonts *.[ot]tf && fc-cache -f
fi
popd

# Install programs that are not available with `apt`.
pushd $(mktemp -d)
cargo install --locked starship                                                          # Starship
curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net | sh -s         # Tectonic
curl --proto '=https' --tlsv1.2 -fsSL https://install.pwndbg.re | sh -s -- -t pwndbg-gdb # Pwndbg
sudo install -Dm 0755 -t /usr/local/bin tectonic
popd
