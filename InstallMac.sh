#!/bin/bash

# Create a directory for local binaries if it doesn't exist
mkdir -p "$HOME/.local/bin"

# Copy kbot.py to the bin directory
cp kbot.py "$HOME/.local/bin/kbot"

# Make it executable
chmod +x "$HOME/.local/bin/kbot"

# Add ~/.local/bin to PATH if it's not already there
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo 'Added ~/.local/bin to PATH in ~/.bashrc. Please restart your terminal or run:'
    echo 'source ~/.bashrc'
fi

echo "Run "
