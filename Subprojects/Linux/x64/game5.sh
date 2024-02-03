#!/bin/sh
echo -ne '\033c\033]0;Game 5\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/game5.x86_64" "$@"
