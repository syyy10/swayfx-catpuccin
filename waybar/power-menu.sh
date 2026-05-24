#!/bin/bash

LOCK="󰌾  Lock"
LOGOUT="󰍃  Logout"
SUSPEND="󰒲  Suspend"
REBOOT="󰑓  Reboot"
SHUTDOWN="󰐥  Shutdown"

CHOICE=$(printf "%s\n%s\n%s\n%s\n%s" "$LOCK" "$LOGOUT" "$SUSPEND" "$REBOOT" "$SHUTDOWN" \
    | wofi --dmenu \
           --prompt "Power" \
           --width 200 \
           --height 215 \
           --no-actions \
           --insensitive \
           --cache-file /dev/null \
           --hide-scroll)

case "$CHOICE" in
    "$LOCK")      loginctl lock-session ;;
    "$LOGOUT")    swaymsg exit ;;
    "$SUSPEND")   systemctl suspend ;;
    "$REBOOT")    systemctl reboot ;;
    "$SHUTDOWN")  systemctl poweroff ;;
esac
