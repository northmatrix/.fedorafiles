#!/usr/bin/env sh
# super tiny status: time + focused window title (polling every second)
while :; do
    # focused window title
    title=$(swaymsg -t get_tree | jq -r '.. | select(.focused?==true) .name' 2>/dev/null | sed -n '1p')
    [ -z "$title" ] && title="(no focused)"
    # workspaces
    ws=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name' 2>/dev/null)
    date=$(date '+%Y-%m-%d %H:%M:%S')
    echo "{\"text\":\"[${ws}] ${title}  |  ${date}\"}"
    sleep 1
done

