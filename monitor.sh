#!/bin/bash

BASE="/home/ubuntu/self-healing-maintenance-system"

STATE_FILE="$BASE/state/mode.txt"
FAIL_FILE="$BASE/state/fail_count.txt"
RESTART_FILE="$BASE/state/restart_count.txt"
LOG_FILE="$BASE/state/monitor.log"

URL="http://127.0.0.1"

STATUS=$(/usr/bin/curl -s -o /dev/null -w "%{http_code}" "$URL")

if [ "$STATUS" -ne 200 ]; then
  echo "Website DOWN detected at $(date)" >> "$LOG_FILE"

  FAIL_COUNT=$(cat "$FAIL_FILE")
  FAIL_COUNT=$((FAIL_COUNT + 1))
  echo "$FAIL_COUNT" > "$FAIL_FILE"

  echo "Failure count: $FAIL_COUNT" >> "$LOG_FILE"

  if [ "$FAIL_COUNT" -ge 3 ]; then
    echo "Threshold reached. Starting recovery at $(date)" >> "$LOG_FILE"
    echo "maintenance" > "$STATE_FILE"

    sudo cp "$BASE/site/maintenance.html" /var/www/html/index.html
    sudo systemctl restart nginx

    echo "Nginx restarted at $(date)" >> "$LOG_FILE"

    RESTART_COUNT=$(cat "$RESTART_FILE")
    RESTART_COUNT=$((RESTART_COUNT + 1))
    echo "$RESTART_COUNT" > "$RESTART_FILE"
  fi

else
  echo "0" > "$FAIL_FILE"

  CURRENT_MODE=$(cat "$STATE_FILE")

  if [ "$CURRENT_MODE" = "maintenance" ]; then
    echo "Website RECOVERED at $(date)" >> "$LOG_FILE"
    echo "normal" > "$STATE_FILE"
    sudo cp "$BASE/site/index.html" /var/www/html/index.html
  fi
fi
