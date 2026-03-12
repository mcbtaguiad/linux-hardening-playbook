#!/bin/bash

CONFIG="/etc/telegram_login_alert.conf"

if [ ! -f "$CONFIG" ]; then
    exit 0
fi

source "$CONFIG"

IP="${PAM_RHOST:-local}"
USER="${PAM_USER}"
HOST=$(hostname)
DATE=$(date)

# Detect login or logout
if [ "$PAM_TYPE" = "open_session" ]; then
    EVENT="SSH LOGIN"
elif [ "$PAM_TYPE" = "close_session" ]; then
    EVENT="SSH LOGOUT"
else
    exit 0
fi

MESSAGE="$EVENT
User: $USER
Host: $HOST
IP: $IP
Time: $DATE"

curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
     -d chat_id="${CHAT_ID}" \
     -d text="$MESSAGE" \
     -d parse_mode="Markdown" >/dev/null 2>&1
