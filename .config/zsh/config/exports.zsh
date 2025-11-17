[[ $PATH =~ "$HOME/.local/bin" ]] || export PATH="$HOME/.local/bin:$PATH"
[[ $PATH =~ "$CARGO_HOME/bin" ]] || export PATH="$CARGO_HOME/bin:$PATH"
[[ $PATH =~ "$GOPATH/bin" ]] || export PATH="$GOPATH/bin:$PATH"

# Swap files, directories, links, etc.
function swap
{
    local T=$(mktemp -d --tmpdir swap.XXXXXXXXXX) \
        && mv "$1" "$T" && mv "$2" "$1" && mv "$T/$1" "$2" && rmdir "$T"
}
