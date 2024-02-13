#!/bin/bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

DESKTOP_IMAGE="${DESKTOP_IMAGE:-/usr/share/backgrounds/kali-16x9/kali-cubism.jpg}"

# Set the desktop image.
for property in $(xfconf-query -c xfce4-desktop -l | grep 'workspace0/last-image'); do
    xfconf-query -c xfce4-desktop -p "$property" -s "$DESKTOP_IMAGE"
done

# Disable desktop icons.
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem  -s false
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-home        -s false
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-removable   -s false
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-trash       -s false

# Edit keyboard layouts.
xfconf-query -c keyboard-layout -p /Default/XkbLayout -n -t string -t string -s us -s ru
xfconf-query -c keyboard-layout -p /Default/XkbOptions/Control -n -t string -s ctrl:nocaps
xfconf-query -c keyboard-layout -p /Default/XkbOptions/Compose -n -t string -s compose:ralt
xfconf-query -c keyboard-layout -p /Default/XkbOptions/Group -n -t string -s grp:ctrl_alt_toggle

# Enable reverse scrolling for touchpads.
for property in $(xfconf-query -c xfce4-desktop -l | grep 'Touchpad/ReverseScrolling'); do
    xfconf-query -c xfce4-desktop -p "$property" -s true
done

# Set timeouts to turn off the screen when on AC/battery power.
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-ac           15
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-off        15
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-sleep      15
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-battery      10
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-battery-off   10
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-battery-sleep 10

# Remap keyboard shortcuts.
user_terminal_command=$(xfconf-query -c xfce4-keyboard-shortcuts -p '/commands/default/<Primary><Alt>t' -v)
root_terminal_command=$(xfconf-query -c xfce4-keyboard-shortcuts -p '/commands/default/<Primary><Shift><Alt>t' -v)
xfconf-query -c xfce4-keyboard-shortcuts -p '/commands/custom/<Super>Return'        -n -t string -s "$user_terminal_command"
xfconf-query -c xfce4-keyboard-shortcuts -p '/commands/custom/<Shift><Super>Return' -n -t string -s "$root_terminal_command"

# Set default applications.
cat << END > "$XDG_CONFIG_HOME/xfce4/helpers.rc"
TerminalEmulator=alacritty
WebBrowser=firefox
END
