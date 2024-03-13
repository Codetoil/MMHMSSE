#!/bin/sh
# Run this on x86_64 Linux

git init
git remote add origin https://github.com/Codetoil/Game.git
git pull origin master
wget https://github.com/godotengine/godot/releases/download/4.2.1-stable/Godot_v4.2.1-stable_linux.x86_64.zip
unzip Godot_v4.2.1-stable_linux.x86_64.zip
wget https://github.com/godotengine/godot/releases/download/4.2.1-stable/Godot_v4.2.1-stable_export_templates.tpz
mkdir -p ~/.local/share/godot/export_templates/
unzip Godot_v4.2.1-stable_export_templates.tpz -d ~/.local/share/godot/export_templates
mv ~/.local/share/godot/export_templates/templates ~/.local/share/godot/export_templates/4.2.1.stable
mkdir -p Godot/bin/debug/Linux/x86_64
mkdir -p Godot/bin/release/Linux/x86_64
mkdir -p Godot/addons/game_swift/debug/Linux/x86_64
./copy-swift-binaries-linux-x86_64.sh