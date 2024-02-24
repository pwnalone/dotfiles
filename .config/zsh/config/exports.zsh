[[ $PATH =~ "$HOME/.local/bin" ]] || export PATH="$HOME/.local/bin:$PATH"
[[ $PATH =~ "$HOME/.cargo/bin" ]] || export PATH="$HOME/.cargo/bin:$PATH"
[[ $PATH =~ "$HOME/.r2env/bin" ]] || export PATH="$HOME/.r2env/bin:$PATH"
[[ $PATH =~ "$GOPATH/bin" ]] || export PATH="$GOPATH/bin:$PATH"

# Swap files, directories, links, etc.
function swap
{
    local T=$(mktemp -d --tmpdir swap.XXXXXXXXXX) \
        && mv "$1" "$T" && mv "$2" "$1" && mv "$T/$1" "$2" && rmdir "$T"
}
