#!/bin/bash
tigervncserver -xstartup /usr/bin/i3 -localhost  -rfbport 5900 :1
setsid /usr/share/novnc/utils/novnc_proxy --listen 2205 --vnc localhost:5900 >/dev/null 2>&1 < /dev/null &
