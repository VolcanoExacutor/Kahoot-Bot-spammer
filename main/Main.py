#!/usr/bin/env python3
import argparse
import warnings
from urllib3.exceptions import NotOpenSSLWarning
import requests
import urllib3
import time

# Suppress urllib3 OpenSSL warning
warnings.filterwarnings("ignore", category=NotOpenSSLWarning)
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# Colors
RED = "\033[31m"
GREEN = "\033[32m"
YELLOW = "\033[33m"
RESET = "\033[0m"

def main():
    parser = argparse.ArgumentParser(
        description=f"{GREEN}Kahoot Bot CLI - Send bots to a Kahoot game{RESET}"
    )
    parser.add_argument("-p", "--pin", required=True, help="Kahoot game PIN")
    parser.add_argument("-a", "--amount", required=True, type=int, help="Number of bots to join (1-50)")
    parser.add_argument("-n", "--name", required=True, help="Nickname for the bot")
    args = parser.parse_args()

    pin = args.pin
    amount = args.amount
    name = args.name

    # Validation
    if not pin.isdigit():
        print(f"{RED}[-] Error: PIN must be numeric{RESET}")
        return
    if amount < 1 or amount > 50:
        print(f"{RED}[-] Error: Amount must be between 1 and 50{RESET}")
        return
    if len(name.strip()) == 0 or len(name) > 20:
        print(f"{RED}[-] Error: Name must be 1-20 characters{RESET}")
        return

    print(f"{GREEN}[+] Starting KBot with PIN {pin}, {amount} bots, nickname '{name}'{RESET}")

    url = "https://kahootbot.net/api/init"
    client_id = "qm68612le"

    for i in range(1, amount + 1):
        bot_name = f"{name}_{i}"
        payload = {
            "pin": pin,
            "amount": 1,
            "name": bot_name,
            "clientId": client_id,
            "recaptchaToken": "true"
        }

        print(f"{YELLOW}[!] Sending bot {i}/{amount}: {bot_name}{RESET}")
        try:
            response = requests.post(url, data=payload, verify=False)
            if response.ok:
                print(f"{GREEN}[+] Bot {i} joined successfully!{RESET}")
            else:
                print(f"{RED}[-] Bot {i} failed to join: {response.status_code}{RESET}")
        except requests.RequestException as e:
            print(f"{RED}[-] Bot {i} network error: {e}{RESET}")
        time.sleep(0.5)  # short delay to reduce server load

    print(f"{GREEN}[+] All bots processed!{RESET}")

if __name__ == "__main__":
    main()
