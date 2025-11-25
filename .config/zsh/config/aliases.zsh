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
alias sl='ls'

# Vim
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

# Colorize the directory tree if outputting to a tty and ignore some files/directories.
alias tree='CLICOLOR=1 tree -I .git -I .github --gitignore'

# Make searches case-insensitive and interpret ANSI "color" escape sequences.
alias less='less -i -R'

# Easily display and navigate the directory stack.
alias d='dirs -v'

for index ({1..9}) alias "$index"="cd +$index"; unset index
