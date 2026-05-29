#!/bin/bash
# Basic hardening script voor Ubuntu servers
# Toepassingen: root SSH lock, backup sudo account, disable root shell,
# fail2ban, unattended upgrades

# === 1. Maak backup sudo gebruiker aan ===
# roy-backup wordt toegevoegd aan sudo groep
# Wachtwoord op dit moment "blanc", kan later aangepast worden
useradd -m -s /bin/bash roy-backup
echo "roy-backup:Welkom123@" | chpasswd
usermod -aG sudo roy-backup
echo "[+] Backup sudo user roy-backup aangemaakt"

# === 2. Disable root login via SSH ===
# Wijzigt SSH configuratie zodat root niet via SSH kan inloggen
SSHD_CONFIG="/etc/ssh/sshd_config"
if grep -q "^PermitRootLogin" $SSHD_CONFIG; then
    sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' $SSHD_CONFIG
else
    echo "PermitRootLogin no" >> $SSHD_CONFIG
fi
systemctl restart ssh
echo "[+] Root login via SSH uitgeschakeld"

# === 3. Disable root shell ===
# Root krijgt geen shell meer om interactief in te loggen
usermod -s /usr/sbin/nologin root
echo "[+] Root shell uitgeschakeld"

# === 4. Installeren en configureren fail2ban ===
apt update && apt install -y fail2ban
systemctl enable --now fail2ban
echo "[+] Fail2ban geïnstalleerd en gestart"

# === 5. Unattended Security Updates ===
apt install -y unattended-upgrades
dpkg-reconfigure -plow unattended-upgrades
echo "[+] Unattended Security Updates geconfigureerd"

echo "[+] Basic hardening voltooid!"
