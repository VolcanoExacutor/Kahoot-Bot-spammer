==================================================
KBot - Kahoot Bot CLI
==================================================

KBot is a command-line tool to send bots to a Kahoot game. It supports multiple bots, custom nicknames, and has robust error handling.

⚠️ Disclaimer: For educational or testing purposes only. Using bots in live games without permission may violate Kahoot's terms of service.

--------------------------------------------------
Features
--------------------------------------------------

- Send multiple bots to a Kahoot game using a PIN.
- Set custom nicknames for each bot.
- Fully command-line driven: -p (PIN), -a (Amount), -n (Name).
- Built-in help: -h or --help.
- Robust error handling for invalid PINs, amounts, names, or network issues.
- Cross-platform installer for macOS/Linux (non-sudo).

--------------------------------------------------
Installation (Linux/macOS, Non-Sudo)
--------------------------------------------------

Step 1: Download the installer:
curl -sL https://raw.githubusercontent.com/YourUsername/YourRepo/main/install.sh -o install.sh

Step 2: Run the installer:
bash install.sh

Step 3: Restart your terminal or source your shell configuration:
source ~/.bashrc   # or ~/.zshrc for zsh

Step 4: Verify installation:
kbot -h

--------------------------------------------------
Dependencies
--------------------------------------------------

- Python 3.6 or higher
- Python package 'requests' (pip3 install requests)
- curl
- bash or zsh shell

--------------------------------------------------
Usage
--------------------------------------------------

Run KBot with your game PIN, number of bots, and nickname:
kbot -p <PIN> -a <AMOUNT> -n <NAME>

Arguments:

- -p Kahoot game PIN (numeric)
- -a Number of bots to join (1-50)
- -n Nickname for the bot (max 20 characters)

Example:
kbot -p 8747647 -a 10 -n Nathaniel

--------------------------------------------------
Error Handling
--------------------------------------------------

- PIN is non-numeric or invalid length
- Amount is not a number or outside 1-50
- Name is empty or too long
- Network issues or server errors
- Keyboard interruption (Ctrl+C)

--------------------------------------------------
Contributing
--------------------------------------------------

Feel free to open issues or submit pull requests. Ensure your contributions follow proper Python style and include error handling.

--------------------------------------------------
License
--------------------------------------------------

This project is licensed under the MIT License. See the LICENSE file for details.
