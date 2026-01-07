



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
PACKAGES="$EDITOR_MAIN"



echo "=== Installazione NeoVim package             ==="
echo "=== Verranno installati i seguenti pacchetti ==="
echo $PACKAGES 

sleep 1

# Aggiorno il sistema
#echo "UPdateding the system, add root password"
sudo pacman -Syu

# Installo i pacchetti
sudo pacman -S $PACKAGES




echo "[+] Debug packages installed."



cp ./init.lua ~/.config/nvim/

#Set elixir-ls
git clone https://github.com/elixir-lsp/elixir-ls.git ~/elixir-ls
cd ~/elixir-ls
mix deps.get
mix compile
mix elixir_ls.release

#install font for nvim
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
unzip FiraCode.zip
fc-cache -fv



