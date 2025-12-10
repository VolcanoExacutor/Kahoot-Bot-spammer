#!/bin/bash

set -e  # Exit on error

BIN_DIR="$HOME/.local/bin"
SCRIPT_URL="https://raw.githubusercontent.com/VolcanoExacutor/Kahoot-Bot-spammer/refs/heads/main/main/Main.py"
KBOT_PATH="$BIN_DIR/kbot.py"
WRAPPER="$BIN_DIR/kbot"

# Function to print errors in red
error() {
    echo -e "\e[31mError: $1\e[0m"
}

# Function to print success in green
success() {
    echo -e "\e[32m$1\e[0m"
}

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    error "curl is not installed. Please install curl and run this script again."
    exit 1
fi

# Create local bin directory
mkdir -p "$BIN_DIR" || { error "Failed to create $BIN_DIR"; exit 1; }

# Download the Python script
echo "Downloading kbot..."
if ! curl -fLsS "$SCRIPT_URL" -o "$KBOT_PATH"; then
    error "Failed to download kbot script from $SCRIPT_URL"
    exit 1
fi

# Make it executable
chmod +x "$KBOT_PATH" || { error "Failed to make kbot executable"; exit 1; }

# Detect shell
SHELL_RC="$HOME/.bashrc"
if [ "$SHELL" = "/bin/zsh" ]; then
    SHELL_RC="$HOME/.zshrc"
fi

# Add bin directory to PATH if missing
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_RC"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC" || { error "Failed to update PATH in $SHELL_RC"; exit 1; }
    echo "Added $BIN_DIR to PATH. Restart your terminal or run: source $SHELL_RC"
fi

# Create wrapper so user can run 'kbot' directly
echo -e "#!/bin/bash\npython3 \"$KBOT_PATH\" \"\$@\"" > "$WRAPPER" || { error "Failed to create wrapper"; exit 1; }
chmod +x "$WRAPPER" || { error "Failed to make wrapper executable"; exit 1; }

success "Installation complete! You can now run 'kbot -h' for help."
