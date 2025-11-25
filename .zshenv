# Editor
export EDITOR=nvim
export VISUAL=nvim

# Browser
export BROWSER=firefox

# Manual Pages
export MANPAGER='nvim +Man!'

# XDG
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# XDG Compliancy
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
