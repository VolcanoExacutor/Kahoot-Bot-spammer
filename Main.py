#!/usr/bin/env python3
import argparse
import requests

def send_request(pin, amount, name):
    url = "https://kahootbot.net/api/init"
    headers = {
        "accept": "*/*",
        "accept-language": "en-US,en;q=0.9,nl;q=0.8,pl;q=0.7,fr;q=0.6,vi;q=0.5,hu;q=0.4,fa;q=0.3,zh-CN;q=0.2,zh;q=0.1",
        "content-type": "application/x-www-form-urlencoded",
        "origin": "https://kahootbot.net",
        "priority": "u=1, i",
        "referer": "https://kahootbot.net/",
        "sec-ch-ua": '"Chromium";v="140", "Not=A?Brand";v="24", "Opera GX";v="124"',
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": '"macOS"',
        "sec-fetch-dest": "empty",
        "sec-fetch-mode": "cors",
        "sec-fetch-site": "same-origin",
        "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 OPR/124.0.0.0 (Edition std-1)"
    }

    data = {
        "pin": pin,
        "amount": amount,
        "name": name,
        "clientId": "qm68612le",
        "recaptchaToken": "true"
    }

    try:
        response = requests.post(url, headers=headers, data=data)
        if response.status_code == 200:
            print("Request sent successfully!")
            print(response.text)
        else:
            print(f"Failed to send request. Status code: {response.status_code}")
            print(response.text)
    except Exception as e:
        print(f"Error sending request: {e}")


def main():
    parser = argparse.ArgumentParser(
        description="Kahoot Bot CLI - Send bots to a Kahoot game",
        epilog="Example:\n  kbot -p 8747647 -a 10 -n Nathaniel",
        formatter_class=argparse.RawDescriptionHelpFormatter
    )

    parser.add_argument(
        "-p", "--pin",
        type=str,
        required=True,
        help="Kahoot game PIN"
    )
    parser.add_argument(
        "-a", "--amount",
        type=int,
        required=True,
        help="Number of bots to join (1-50)"
    )
    parser.add_argument(
        "-n", "--name",
        type=str,
        required=True,
        help="Nickname for the bot"
    )

    args = parser.parse_args()

    # Validate amount
    if not 1 <= args.amount <= 50:
        print("Error: amount must be between 1 and 50")
        return

    # Validate PIN
    if not args.pin.isdigit():
        print("Error: pin must be numeric")
        return

    send_request(args.pin, args.amount, args.name)


if __name__ == "__main__":
    main()
