#!/bin/sh
# Run this on x86_64 Linux

./build-linux-x86_64.sh
./Godot_v4.2.1-stable_linux.x86_64  --path ./Godot --headless --export-debug "Linux/X11 x86_64" ./bin/debug/Linux/x86_64/
