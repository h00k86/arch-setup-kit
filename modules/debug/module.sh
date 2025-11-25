



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
PACKAGES="$DEBUG_MAIN"



echo "=== Installazione Debug package               ==="
echo "=== Verranno installati i seguenti pacchetti ==="
echo $PACKAGES 

sleep 1

# Aggiorno il sistema
#echo "UPdateding the system, add root password"
sudo pacman -Syu

# Installo i pacchetti
sudo pacman -S $PACKAGES



#installing pwndbg
curl -qsL 'https://install.pwndbg.re' | sh -s -- -t pwndbg-gdb


#installing pwntool


echo "[+] Debug packages installed."


