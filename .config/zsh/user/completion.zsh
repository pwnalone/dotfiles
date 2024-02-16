# This list was taken from the ohmyzsh/ohmyzsh GitHub repo.
# See: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/completion.zsh
IGNORED_USERS=(
    adm
    amanda
    apache
    at
    avahi
    avahi-autoipd
    beaglidx
    bin
    cacti
    canna
    clamav
    daemon
    dbus
    distcache
    dnsmasq
    dovecot
    fax
    ftp
    games
    gdm
    gkrellmd
    gopher
    hacluster
    haldaemon
    halt
    hsqldb
    ident
    junkbust
    kdm
    ldap
    lp
    mail
    mailman
    mailnull
    man
    messagebus
    mldonkey
    mysql
    nagios
    named
    netdump
    news
    nfsnobody
    nobody
    nscd
    ntp
    nut
    nx
    obsrun
    openvpn
    operator
    pcap
    polkitd
    postfix
    postgres
    privoxy
    pulse
    pvm
    quagga
    radvd
    rpc
    rpcuser
    rpm
    rtkit
    scard
    shutdown
    squid
    sshd
    statd
    svn
    sync
    tftp
    usbmux
    uucp
    vcsa
    wwwrun
    xfs
)

zmodload zsh/complist
autoload -Uz compinit

# Enable menu selection for completions.
zstyle ':completion:*' menu select

# Make completions case-/hyphen-insensitive and match partial words/substrings.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'

# When completing processes display the PID, user, and command (in color).
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"

# Use caching so that completion for commands like `apt` and `dpkg` works.
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh"

# Ignore uninteresting accounts for username completion.
zstyle ':completion:*:*:*:users' ignored-patterns "${IGNORED_USERS[@]}" '_*'

# Show ignored completions when there is a single match.
zstyle '*' single-ignored show

# Get extra completions.
source "$ZDOTDIR/plugins/zsh-completions/zsh-completions.plugin.zsh"
fpath+=("$ASDF_DIR/completions")

# Initialize completion.
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Complete hidden files.
_comp_options+=(globdots)
