#!/bin/bash
tigervncserver -xstartup /usr/bin/startxfce4 -localhost  -rfbport 5901 :2
setsid /usr/share/novnc/utils/novnc_proxy --listen 2206 --vnc localhost:5901 >/dev/null 2>&1 < /dev/null &
#xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVNC-0/workspace0/last-image -s /vagrant/.Provisioning/DesktopBackgrounds/china-street-1920×1080.jpg