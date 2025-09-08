#!/bin/bash
# auto-update.sh
# Eenvoudig script om updates & upgrades automatisch uit te voeren

# Logbestand
LOGFILE="/var/log/auto-update.log"

# Datum en tijd in log zetten
echo "===== $(date '+%Y-%m-%d %H:%M:%S') =====" >> "$LOGFILE"

# Update en upgrade uitvoeren
apt-get update -y >> "$LOGFILE" 2>&1
apt-get upgrade -y >> "$LOGFILE" 2>&1
apt-get autoremove -y >> "$LOGFILE" 2>&1
apt-get autoclean -y >> "$LOGFILE" 2>&1

echo "Updates voltooid." >> "$LOGFILE"
echo "" >> "$LOGFILE"