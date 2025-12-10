#!/bin/bash

# Installer for KBot (macOS/Linux)
# Non-sudo, with colors and error suppression

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Suppress curl progress output
CURL_OPTS="-sS --fail"

SCRIPT_URL="https://raw.githubusercontent.com/VolcanoExacutor/Kahoot-Bot-spammer/main/Main.py"
INSTALL_DIR="$HOME/.local/bin"

echo -e "${GREEN}[+] Creating install directory: $INSTALL_DIR${NC}" 2>/dev/null
mkdir -p "$INSTALL_DIR" 2>/dev/null

echo -e "${GREEN}[+] Downloading KBot...${NC}"
curl $CURL_OPTS "$SCRIPT_URL" -o "$INSTALL_DIR/kbot.py" 2>/dev/null

if [ $? -ne 0 ]; then
    echo -e "${RED}[-] Failed to download KBot script! Check your internet or URL.${NC}"
    exit 1
fi

echo -e "${GREEN}[+] Download complete.${NC}"

echo -e "${GREEN}[+] Making KBot executable...${NC}"
chmod +x "$INSTALL_DIR/kbot.py" 2>/dev/null

# Create wrapper to run as 'kbot'
WRAPPER="$INSTALL_DIR/kbot"
echo -e "${GREEN}[+] Creating wrapper script: $WRAPPER${NC}"
cat > "$WRAPPER" << EOF
#!/bin/bash
python3 "$INSTALL_DIR/kbot.py" "\$@"
EOF

chmod +x "$WRAPPER" 2>/dev/null

# Add ~/.local/bin to PATH if not already
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    SHELL_RC="$HOME/.bashrc"
    [[ -f "$HOME/.zshrc" ]] && SHELL_RC="$HOME/.zshrc"
    echo -e "${YELLOW}[!] Adding $INSTALL_DIR to PATH in $SHELL_RC${NC}"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC" 2>/dev/null
    echo -e "${GREEN}[+] PATH updated. Restart your terminal or run: source $SHELL_RC${NC}"
fi

echo -e "${GREEN}[+] Installation complete! You can now run: kbot -h${NC}"
