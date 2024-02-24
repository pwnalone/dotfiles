zmodload zsh/terminfo

# Use Shift-Tab to select the previous item in completion menu.
if [[ -n "${terminfo[kcbt]}" ]]; then
    bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
    bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
    bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
fi
