#!/bin/bash
# Installatie-script voor automatische updates via cron
# Gebruik: sudo ./install-auto-update.sh <RAW_GIT_URL>
#
# Voorbeeld:
# sudo ./install-auto-update.sh https://raw.githubusercontent.com/USERNAME/REPO/main/auto-update.sh

if [ -z "$1" ]; then
    echo "❌ Geen URL opgegeven."
    echo "Gebruik: sudo $0 <RAW_GIT_URL>"
    exit 1
fi

RAW_URL="$1"
SCRIPT_PATH="/usr/local/bin/auto-update.sh"
CRON_JOB="0 3 * * * $SCRIPT_PATH"
CRON_MARKER="# AUTO-UPDATE-SCRIPT"

echo "⬇️ Downloaden van auto-update script vanaf:"
echo "$RAW_URL"

# Script downloaden
curl -fsSL "$RAW_URL" -o "$SCRIPT_PATH"
if [ $? -ne 0 ]; then
    echo "❌ Download mislukt. Check de URL."
    exit 1
fi

chmod +x "$SCRIPT_PATH"

# Cronjob toevoegen als hij nog niet bestaat
( crontab -l 2>/dev/null | grep -v "$CRON_MARKER" ; echo "$CRON_MARKER"; echo "$CRON_JOB" ) | crontab -

echo "✅ Automatisch update-script geïnstalleerd!"
echo "ℹ️  Updates draaien nu elke dag om 03:00 uur."
echo "📜 Log: /var/log/auto-update.log"
