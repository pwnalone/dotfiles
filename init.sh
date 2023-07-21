#!/bin/sh

set -e

# Sudo not needed if running as root.
if [ $(id -u) -eq 0 ]; then
    sudo=''
fi

# Ensure these directories are in our PATH for later configuration.
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.r2env/bin:$PATH"

# Upgrade old packages.
sudo apt update && sudo apt upgrade -y

# Uninstall default r2.
sudo apt purge -y radare2 && sudo apt autoremove -y

# Install new packages.
sudo apt install -y \
    binutils \
    binwalk \
    build-essential \
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
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    ltrace \
    man-db \
    moreutils \
    nasm \
    neovim \
    nmap \
    patchelf \
    pipx \
    python3-pynvim \
    python3-venv \
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

# Install GNU which (which is a better version of default `which` utility).
curl --proto '=https' --tlsv1.2 https://carlowood.github.io/which/which-2.21.tar.gz -sSf | tar -zxvf -
cd which-2.21 && ./configure && make && sudo make install && cd -
rm -rf which-2.21

# Set zsh as the default shell.
chsh -s $(which zsh) $USER

# Install Antigen zsh package manager.
sudo mkdir -p /usr/share/zsh/scripts
sudo curl -L git.io/antigen -o /usr/share/zsh/scripts/antigen.zsh

# Install Rust.
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path

# Install utilities with cargo.
cargo install bat lsd tokei

# Install GDB plugins.
mkdir -p $HOME/.gdb/plugins
git clone https://github.com/hugsy/gef.git     $HOME/.gdb/plugins/gef
git clone https://github.com/pwndbg/pwndbg.git $HOME/.gdb/plugins/pwn
cd $HOME/.gdb/plugins/pwn && ./setup.sh --update && cd -

# Install pyenv.
git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv

# Install last Python 2 version.
pyenv install 2.7.18

# Install standalone Python applications with pipx.
for pkg in ipython pipenv pwntools r2env ropper; do pipx install $pkg; done

# Install r2.
r2env add radare2@git
r2env use radare2@git

# Install r2 plugins.
r2pm -U
r2pm -i r2ghidra
r2pm -i iref
