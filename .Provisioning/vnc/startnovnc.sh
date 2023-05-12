#!/bin/bash
tigervncserver -xstartup /usr/bin/startxfce4 -localhost  -rfbport 5900
setsid /usr/share/novnc/utils/novnc_proxy --listen 8081 --vnc localhost:5900 >/dev/null 2>&1 < /dev/null &
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVNC-0/workspace0/last-image -s /vagrant/.Provisioning/DesktopBackgrounds/china-street-1920×1080.jpg