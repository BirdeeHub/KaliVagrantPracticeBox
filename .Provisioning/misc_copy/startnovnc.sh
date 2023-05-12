#!/bin/bash
tigervncserver -xstartup /usr/bin/startxfce4 -localhost  -rfbport 5900
setsid /usr/share/novnc/utils/novnc_proxy --listen 8081 --vnc localhost:5900 >/dev/null 2>&1 < /dev/null &
