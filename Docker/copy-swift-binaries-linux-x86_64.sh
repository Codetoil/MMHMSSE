#!/bin/sh
# Run this on x86_64 Linux

SWIFT_LOC=$(which swift)
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libswiftSwiftOnoneSupport.so Godot/addons/game_swift/debug/Linux/x86_64/
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libswiftCore.so Godot/addons/game_swift/debug/Linux/x86_64/
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libswift_Concurrency.so Godot/addons/game_swift/debug/Linux/x86_64/
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libswift_StringProcessing.so Godot/addons/game_swift/debug/Linux/x86_64/
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libswiftGlibc.so Godot/addons/game_swift/debug/Linux/x86_64/
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libBlocksRuntime.so Godot/addons/game_swift/debug/Linux/x86_64/
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libdispatch.so Godot/addons/game_swift/debug/Linux/x86_64/
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libswiftDispatch.so Godot/addons/game_swift/debug/Linux/x86_64/
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libFoundation.so Godot/addons/game_swift/debug/Linux/x86_64/
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libswift_RegexParser.so Godot/addons/game_swift/debug/Linux/x86_64/
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libicuucswift.so.69 Godot/addons/game_swift/debug/Linux/x86_64/
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libicui18nswift.so.69 Godot/addons/game_swift/debug/Linux/x86_64/
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libicui18nswift.so.69 Godot/addons/game_swift/debug/Linux/x86_64/
cp "${SWIFT_LOC%bin/swift}"/lib/swift/linux/libicudataswift.so.69 Godot/addons/game_swift/debug/Linux/x86_64/
