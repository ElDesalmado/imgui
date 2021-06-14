#!/bin/bash
echo "Installing dependencies with pacman..."
pacman --noconfirm --needed -S mingw-w64-x86_64-SDL2 \
mingw-w64-x86_64-glfw
