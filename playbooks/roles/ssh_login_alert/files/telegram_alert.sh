#!/bin/bash

CONFIG="/etc/telegram_login_alert.conf"

if [ ! -f "$CONFIG" ]; then
    exit 0
fi

source $CONFIG

IP=$(echo $PAM_RHOST)
USER=$(echo $PAM_USER)
HOST=$(hostname)
DATE=$(date)

MESSAGE="SSH Login Alert
User: $USER
Host: $HOST
IP: $IP
Time: $DATE"

curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
     -d chat_id="${CHAT_ID}" \
     -d text="$MESSAGE" >/dev/null 2>&1
