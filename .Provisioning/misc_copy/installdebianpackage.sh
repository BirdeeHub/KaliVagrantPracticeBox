#!/bin/bash
InstallDir="/usr/local/games/minesweeper"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
sudo dpkg -i $SCRIPT_DIR/minesweeper_1.0-1_amd64.deb
sudo $InstallDir/minesweeper/lib/app/non-windows-post-install-script.sh
