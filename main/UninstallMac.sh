#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

INSTALL_DIR="$HOME/.local/bin"

echo -e "${YELLOW}[!] Uninstalling KBot...${NC}"

# Remove Python script and wrapper
rm -f "$INSTALL_DIR/kbot.py" "$INSTALL_DIR/kbot" 2>/dev/null

echo -e "${GREEN}[+] Removed kbot.py and wrapper${NC}"

# Remove PATH line from shell configs
SHELL_FILES=("$HOME/.bashrc" "$HOME/.zshrc")
for file in "${SHELL_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        sed -i.bak '/~\/.local\/bin/d' "$file" 2>/dev/null
        echo -e "${GREEN}[+] Removed PATH entry from $file (backup saved as $file.bak
