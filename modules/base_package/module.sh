



#!/usr/bin/env bash

# =====================================================
# Modulo CODING - Arch Setup Kit
# Installazione strumenti di sviluppo base
# =====================================================

# Load global config
#!/usr/bin/env bash

CONFIG_FILE="./config.conf"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "config.conf non found!"
    echo $CONFIG_FILE
    exit 1
fi



source "$CONFIG_FILE"

# Lista pacchetti da installare
PACKAGES="$BASE_PACKAGES"



echo "=== Installazione base package               ==="
echo "=== Verranno installati i seguenti pacchetti ==="
echo $PACKAGES 

sleep 1

# Aggiorno il sistema
#echo "UPdateding the system, add root password"
su -c "pacman -Syu;"

# Installo i pacchetti
su -c "pacman -S $PACKAGES"

echo "[+] Base packages installed."


