# Plugins
source "$ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh"

# Zsh Autosuggestions Customizations
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

#
# FIXME: This disables suggestions for command lines like the following...
#
# $ echo '# hi' && cat ...
# $ arr=(1 2 3); echo "${#arr[@]}" && cat ...
#
# Another solution is needed.
#
# Track Issue: https://github.com/zsh-users/zsh-autosuggestions/issues/773
#

# ZSH_AUTOSUGGEST_COMPLETION_IGNORE='*\#*'
# ZSH_AUTOSUGGEST_HISTORY_IGNORE='*\#*'

# Zsh History Substring Search Customizations
bindkey -M vicmd '^J' history-substring-search-down
bindkey -M vicmd '^K' history-substring-search-up
bindkey -M viins '^J' history-substring-search-down
bindkey -M viins '^K' history-substring-search-up

HISTORY_SUBSTRING_SEARCH_FUZZY=1
