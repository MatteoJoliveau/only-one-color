#!/usr/bin/env bash

rm -rf ./build
mkdir build

echo "Publishing Windows binary..."
godot --no-window --export "Windows Desktop" build/only-one.exe
cd build
7z a only-one-windows-amd64.zip only-one.exe only-one.pck
butler push only-one-windows-amd64.zip  definitelycodex/only-one-color-is-safe:windows
cd ..

echo "Publishing Linux binary..."
godot --no-window --export "Linux/X11" build/only-one
cd build
tar -cvf only-one-linux-amd64.tar.gz only-one only-one.pck
butler push only-one-linux-amd64.tar.gz  definitelycodex/only-one-color-is-safe:linux
