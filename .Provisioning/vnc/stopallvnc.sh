#!/bin/bash
ps aux | grep -i '/usr/bin/websockify' | grep -v "grep"
kill $(ps aux | grep -i '/usr/bin/websockify' | grep -v "grep" | awk '{ printf("%d ", $2) }')
ps aux | grep -i '/usr/bin/websockify' | grep -v "grep"
tigervncserver -kill :1
tigervncserver -kill :2
