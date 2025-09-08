#!/bin/bash
# Verwijder het automatische update-script en cronjob
SCRIPT_PATH="/usr/local/bin/auto-update.sh"
CRON_MARKER="# AUTO-UPDATE-SCRIPT"

# Cronjob verwijderen
crontab -l 2>/dev/null | grep -v "$CRON_MARKER" | crontab -

# Script verwijderen
rm -f "$SCRIPT_PATH"

echo "❌ Automatisch update-script en cronjob verwijderd!"
