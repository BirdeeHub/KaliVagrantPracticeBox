#!/usr/bin/env bash
echo "kill socket forwarding:"
ps aux | grep -i '/usr/bin/websockify' | grep -v "grep"
kill $(ps aux | grep -i '/usr/bin/websockify' | grep -v "grep" | awk '{ printf("%d ", $2) }')
tigervncserver -kill :1
tigervncserver -kill :2
