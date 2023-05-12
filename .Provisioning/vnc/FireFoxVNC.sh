#!/bin/bash
export DISPLAY=:$1
firefox >/dev/null 2>&1 < /dev/null &
