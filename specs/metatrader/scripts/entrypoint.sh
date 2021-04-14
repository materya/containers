#!/usr/bin/env sh

export DISPLAY=:1.0
Xvfb $DISPLAY -screen 0 1024x768x16 &

exec "$@"
