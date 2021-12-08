#!/bin/bash

rofi_command="rofi -theme ~/.config/leftwm/themes/current/rofi/powermenu.rasi"

#### Options ###
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $lock)
		if [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		elif [[ -f /usr/bin/i3lock ]]; then
			i3lock
		fi
        ;;    
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $suspend)
		mpc -q pause
		amixer set Master mute
		systemctl suspend
        ;;
    $logout)
		if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
			openbox --exit
		elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
			bspc quit
		elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
			i3-msg exit
			elif [[ "$DESKTOP_SESSION" == "leftwm" ]]; then
			loginctl kill-session $XDG_SESSION_ID
		fi
        ;;
esac

