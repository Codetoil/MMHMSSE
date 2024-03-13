#!/bin/sh
# Run this on x86_64 Linux

swift build -v

rm Godot/addons/game_swift/debug/Linux/x86_64/libGame.so Godot/addons/game_swift/debug/Linux/x86_64/libSwiftGodot.so
cp .build/debug/libGame.so Godot/addons/game_swift/debug/Linux/x86_64/libGame.so
cp .build/debug/libSwiftGodot.so Godot/addons/game_swift/debug/Linux/x86_64/libSwiftGodot.so
