#!/bin/sh

set -e

# Sudo not needed if running as root.
if [ $(id -u) -eq 0 ]; then
    alias sudo=''
fi

# Ensure these directories are in our PATH for later.
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.r2env/bin:$PATH"

# Install dotfiles.
cp -r .config .local .zshenv -t "$HOME"

# Upgrade old packages.
sudo apt update && sudo apt upgrade -y

# Uninstall default r2.
sudo apt purge -y radare2 && sudo apt autoremove -y

# Install new packages.
sudo apt install -y \
    binutils \
    binwalk \
    build-essential \
    cmake \
    curl \
    dstat \
    elfutils \
    forensics-extra \
    g++-multilib \
    gcc-multilib \
    gdb-multiarch \
    git \
    gobuster \
    imagemagick \
    john \
    jq \
    libbz2-dev \
    libfontconfig-dev \
    libfreetype-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxcb-xfixes0-dev \
    libxkbcommon-dev \
    ltrace \
    man-db \
    moreutils \
    nasm \
    nmap \
    patchelf \
    pipx \
    pkg-config \
    python3 \
    python3-pip \
    python3-pynvim \
    python3-venv \
    rustup \
    sleuthkit \
    socat \
    strace \
    tcpdump \
    tree \
    unzip \
    upx-ucl \
    wget \
    xxd \
    zip \
    zsh

# Set zsh as the default shell.
chsh -s $(which zsh) "$USER"

# Install Rust toolchain.
rustup toolchain install stable

# Install Rust applications.
cargo install alacritty bat fd-find feroxbuster lsd ripgrep starship tokei

# Configure starship prompt.
starship preset nerd-font-symbols >> "$HOME/.config/starship.toml"

# Install a nerd font.
FONTNAME='Hermit'
FONTPATH="$HOME/.local/share/fonts/$FONTNAME"
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/$FONTNAME.zip"
mkdir -p "$FONTPATH" && unzip -d "$FONTPATH" "$FONTNAME.zip" && rm -f "$FONTNAME.zip"

# Install lazygit.
LG_VERSION='0.40.2'
LG_ARCHIVE="lazygit_${LG_VERSION}_Linux_x86_64.tar.gz"
curl -sL "https://github.com/jesseduffield/lazygit/releases/download/v$LG_VERSION/$LG_ARCHIVE" \
    | sudo tar -zxf - -C /usr/local/bin lazygit

# Install GDB plugins.
mkdir -p "$HOME/.gdb/plugins"
git clone https://github.com/hugsy/gef     "$HOME/.gdb/plugins/gef"
git clone https://github.com/pwndbg/pwndbg "$HOME/.gdb/plugins/pwn"
cd "$HOME/.gdb/plugins/pwn" && ./setup.sh --update && cd -

# Install pyenv.
git clone https://github.com/pyenv/pyenv "$HOME/.pyenv"

# Install last Python 2 version.
pyenv install 2.7.18

# Install standalone Python applications.
for pkg in frida-tools ipython meson pipenv pwntools r2env ropper; do
    pipx install $pkg
done

# Install r2.
r2env add radare2@git
r2env use radare2@git

# Install r2 plugins.
r2pm -U
r2pm -i r2ghidra
r2pm -i iref

# Install Neovim.
curl -sL https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz \
    | sudo tar -zxf - -C /usr/local --strip-components=1

# Install LunarVim distribution.
export LV_BRANCH='release-1.3/neovim-0.9'
LV_INSTALL=$(mktemp)
curl -sL "https://raw.githubusercontent.com/LunarVim/LunarVim/$LV_BRANCH/utils/installer/install.sh" -o "$LV_INSTALL"
bash "$LV_INSTALL" && rm -f "$LV_INSTALL"
