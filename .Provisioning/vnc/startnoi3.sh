#!/bin/bash
tigervncserver -xstartup /usr/bin/i3 -localhost  -rfbport 5901
setsid /usr/share/novnc/utils/novnc_proxy --listen 2206 --vnc localhost:5901 >/dev/null 2>&1 < /dev/null &
