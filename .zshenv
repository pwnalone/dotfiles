# Editor
export EDITOR=nvim
export VISUAL=nvim

# Browser
export BROWSER=firefox

# Man Pages
export MANPAGER='nvim +Man!'

# XDG
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# Zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Asdf
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
export ASDF_DIR="$XDG_CONFIG_HOME/asdf"
export ASDF_CONFIG_FILE="$ASDF_DIR/asdfrc"

# Golang
export GOPATH="$XDG_DATA_HOME/go"

# Starship
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
