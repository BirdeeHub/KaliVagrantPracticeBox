#!/usr/bin/env bash
export DISPLAY=:$1
burpsuite >/dev/null 2>&1 < /dev/null &
firefox >/dev/null 2>&1 < /dev/null &
