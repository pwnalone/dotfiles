#!/bin/bash

set -e

SCRIPTDIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")

JSPM=npm
PYPM=pipx
GOPM=go
RSPM=cargo

OS_REQUIRED=(
    # Required by many things
    bash
    build-essential
    cmake
    coreutils
    curl
    g++
    gcc
    git
    gzip
    make
    pkgconf
    python3
    python3-pip
    python3-setuptools
    python3-venv
    tar
    unzip
    wget
    zip
    zsh

    # Required to update the fontconfig cache
    fontconfig

    # Required by Tmux config
    fzf

    # Required by GDB plugins
    gdb

    # Required to install Python applications
    pipx

    # Required by asdf-python
    libbz2-dev
    libffi-dev
    liblzma-dev
    libncurses-dev
    libreadline-dev
    libsqlite3-dev
    libssl-dev
    libxml2-dev
    libxmlsec1-dev
    tk-dev
    xz-utils
    zlib1g-dev
)
OS_OPTIONAL=(
    # Kali Linux meta packages (core < headless < default < large < everything)
    kali-linux-default

    # Optionally required by LunarVim
    python3-pynvim

    # Native GCC support for 32-bit architectures
    g++-multilib
    gcc-multilib

    # Useful GDB packages
    gdb-doc
    gdb-multiarch
    gdbserver

    # Web browsers
    firefox-esr

    # Manual pages
    man-db
    manpages

    # Common tools
    diffutils
    findutils
    jq
    less
    moreutils
    plocate
    tree
    xsel
    xxd

    # Binary tools
    binutils
    elfutils
    ltrace
    nasm
    patchelf
    strace

    # Completely optional
    flameshot
    imagemagick
)

JS_REQUIRED=(
)
JS_OPTIONAL=(
    # Optionally required by LunarVim
    neovim
    tree-sitter-cli
)

PY_REQUIRED=(
)
PY_OPTIONAL=(
    # A better way to install radare2
    r2env

    # Completely optional
    frida-tools
    ipython
    meson
    pipenv
    pwntools
    ropper
)

GO_REQUIRED=(
)
GO_OPTIONAL=(
    # Optionally required by LunarVim
    github.com/jesseduffield/lazygit@latest
)

RS_REQUIRED=(
    # Required by Zsh config
    bat
    lsd
    starship
)
RS_OPTIONAL=(
    # Optionally required by LunarVim
    fd-find
    ripgrep

    # Completely optional
    feroxbuster
    tokei
)

OS_PACKAGES=(${OS_REQUIRED[@]} ${OS_OPTIONAL[@]})
JS_PACKAGES=(${JS_REQUIRED[@]} ${JS_OPTIONAL[@]})
PY_PACKAGES=(${PY_REQUIRED[@]} ${PY_OPTIONAL[@]})
GO_PACKAGES=(${GO_REQUIRED[@]} ${GO_OPTIONAL[@]})
RS_PACKAGES=(${RS_REQUIRED[@]} ${RS_OPTIONAL[@]})

# Issue warning if we are running as root without the '--root' flag.
if [ $(id -u) -eq 0 ] && [ "$1" != '--root' ]; then
    echo "Warning: This script should NOT be run as root unless YOU ARE root."
    echo "         Sudo will be used when required."
    echo
    echo "Rerun with '--root' if you know what you are doing."
    exit 1
fi

# Sudo not needed if running as root.
if [ $(id -u) -eq 0 ]; then
    function sudo {
        "$@"
    }
fi

cd "$SCRIPTDIR/../"

# Fetch submodules.
git submodule update --init --recursive --progress

# Ensure these directories are in our PATH for later.
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.r2env/bin:$PATH"

# Ensure files are installed to the correct location.
. ./.zshenv

# Install dotfiles.
mkdir -p "$XDG_CONFIG_HOME"
for f in .config/* .Xmodmap .zshenv; do
    [ -e "$HOME/$f" ] && mv "$HOME/$f" "$HOME/$f.bak"
    ln -sf "$(realpath $f)" "$HOME/$f"
done

# Upgrade old packages.
sudo apt update && sudo apt upgrade -y

# Install new packages.
sudo apt install -y "${OS_PACKAGES[@]}"

# Uninstall Neovim and radare2 -- the packaged versions are too old.
sudo apt purge -y neovim radare2

# Make zsh the default shell.
sudo chsh -s $(which zsh) "$USER"

# Get the asdf command.
. "$XDG_CONFIG_HOME/asdf/asdf.sh"

# Install asdf plugins.
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs
asdf plugin add python https://github.com/asdf-community/asdf-python
asdf plugin add golang https://github.com/asdf-community/asdf-golang

# Install language toolchains/runtimes.
asdf install nodejs latest
asdf install python latest:2
asdf install python latest:3
asdf install golang latest

# Set default versions of language toolchains/runtimes.
asdf global python latest:3 latest:2
asdf global nodejs latest
asdf global golang latest

# Install Rust.
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --component rust-src

# Install Node/Python/Go/Rust applications.
[ ${#JS_PACKAGES[@]} -ne 0 ] && $JSPM install -g "${JS_PACKAGES[@]}"
[ ${#PY_PACKAGES[@]} -ne 0 ] && $PYPM install    "${PY_PACKAGES[@]}"
[ ${#GO_PACKAGES[@]} -ne 0 ] && $GOPM install    "${GO_PACKAGES[@]}"
[ ${#RS_PACKAGES[@]} -ne 0 ] && $RSPM install    "${RS_PACKAGES[@]}"

# Configure starship.
cp "$XDG_CONFIG_HOME/starship/starship.toml.in" "$XDG_CONFIG_HOME/starship/starship.toml"
starship preset nerd-font-symbols >> "$XDG_CONFIG_HOME/starship/starship.toml"

# Setup GDB plugins.
cd "$XDG_CONFIG_HOME/gdb/plugins/pwn" && ./setup.sh --update && cd -

# Install radare2 and plugins if r2env was installed.
if command -v r2env 2>/dev/null; then
    r2env add radare2@git
    r2env use radare2@git
    r2pm -U
    r2pm -i iref
    r2pm -i r2ghidra
    r2pm -i r2ghidra-sleigh
fi

cd "$SCRIPTDIR"

# Install Ulauncher.
./install-ulauncher.sh

# Install Alacritty.
./install-alacritty.sh

# Install nerd font.
./install-nerd-font.sh

# Configure Xfce.
./xfconf-query.sh

# Install Neovim.
curl -sL https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz \
    | sudo tar -zxf - -C /usr/local --strip-components=1
