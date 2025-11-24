


#!/usr/bin/env bash

# ==============================================================
# Module QEMU - Arch Setup Kit
# Installazione strumenti di virtualizzazione
# ==============================================================

CONFIG_FILE="./config.conf"

if [[ ! -f "$CONFIG_FILE" ]]; then

  echo "config.conf not found!"
  exit 1

fi


source "$CONFIG_FILE"


#LISTA PACCHETTI DA INSTALLARE
PACKAGES="$QEMU_PACKAGES"


echo "=== Installazione qemu packages               ==="
echo "=== Verranno installati i seguenti pacchetti  ==="
echo $PACKAGES 



sleep 1

#Update system

su -c "pacman -Syu"

su -c "pacman -S $PACKAGES "

echo "[+] QEMU Packages installed"



