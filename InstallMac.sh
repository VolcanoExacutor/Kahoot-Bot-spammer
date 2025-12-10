#!/bin/bash

# User local bin
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

# Download the Python script
echo "Downloading kbot..."
curl -sL "https://raw.githubusercontent.com/VolcanoExacutor/Kahoot-Bot-spammer/refs/heads/main/Main.py" -o "$BIN_DIR/kbot.py"

# Make it executable
chmod +x "$BIN_DIR/kbot.py"

# Add bin to PATH if not already
SHELL_RC="$HOME/.bashrc"
if [ "$SHELL" = "/bin/zsh" ]; then
    SHELL_RC="$HOME/.zshrc"
fi

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_RC"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
    echo "Added $BIN_DIR to PATH. Please restart terminal or run: source $SHELL_RC"
fi

# Create a small wrapper so user can just type 'kbot'
WRAPPER="$BIN_DIR/kbot"
echo -e "#!/bin/bash\npython3 \"$BIN_DIR/kbot.py\" \"\$@\"" > "$WRAPPER"
chmod +x "$WRAPPER"

echo "Installation complete! You can now run 'kbot -h' for help."
