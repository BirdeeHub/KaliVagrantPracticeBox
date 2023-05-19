#!/bin/bash
InstallDir="/usr/local/games/minesweeper"
sudo $InstallDir/minesweeper/lib/app/non-windows-pre-uninstall-cleanup-RUN-WITH-SUDO.sh
sudo dpkg --purge minesweeper
