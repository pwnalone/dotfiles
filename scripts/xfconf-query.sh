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

# Enable reverse scrolling for touchpads.
for property in $(xfconf-query -c xfce4-desktop -l | grep 'Touchpad/ReverseScrolling'); do
    xfconf-query -c xfce4-desktop -p "$property" -s true
done

# Set timeouts to turn off the screen when on AC/battery power.
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-ac           -n -t int 15
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-off        -n -t int 15
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-sleep      -n -t int 15
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-battery      -n -t int 10
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-battery-off   -n -t int 10
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-battery-sleep -n -t int 10

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
