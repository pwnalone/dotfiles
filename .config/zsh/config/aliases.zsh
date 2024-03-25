# Expand aliases after these commands.
alias nohup='nohup '
alias sudo='sudo '

# Cat
alias cat='bat'

# Git
alias g='git'
alias gg='lazygit'

# Ls
alias l='ll'
alias la='lsd -Ah'
alias li='lsd -Ah -l -i'
alias ll='lsd -Ah -l'
alias ls='lsd'
alias sl='lsd'

# Vim
alias nvim='nvim -o "+silent only"'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'

# Colorize the output of these commands.
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias pacman='pacman --color=auto'
alias yay='yay --color=auto'

# Always colorize the directory tree and ignore .git(hub) directories and files from .gitignore.
alias tree='tree -C -I .git -I .github --gitignore'

# Make searches case-insensitive and interpret ANSI "color" escape sequences.
alias less='less -iR'

# Easily display and navigate the directory stack.
alias d='dirs -v'

for index ({1..9}) alias "$index"="cd +$index"; unset index
