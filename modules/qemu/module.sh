


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

sudo pacman -S $PACKAGES

echo "[+] QEMU Packages installed"

echo "[] Configuring qemu script"

mkdir -p $HOME/VMs

cp "$HOME/CODING/SCRIPT/arch-setup-kit/modules/qemu/qemu-script.sh" $HOME/VMs
cp "$HOME/CODING/SCRIPT/arch-setup-kit/modules/qemu/config.conf" $HOME/VMs
