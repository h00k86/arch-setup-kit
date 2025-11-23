#!/usr/bin/env bash

# =====================================================
# Arch Setup Kit - Script principale
# Menu interattivo per installare moduli
# =====================================================

# Carico la configurazione
if [[ ! -f "./config.conf" ]]; then
    echo "❌ config.conf non trovato!"
    exit 1
fi
source ./config.conf

MODULES_DIR="./modules"

# Funzione per mostrare il menu
show_menu() {
    clear
    echo ""
    echo ""
    echo "  ======================================="
    echo "          ARCH SETUP KIT - MENU          "
    echo "  ======================================="
    echo "  1) Base package"
    echo "  2) Neovim"
    echo "  3) i3 Window Manager"
    echo "  4) QEMU / KVM"
    echo "  5) Install all"
    echo "  0) Exit"
    echo
    read -p "Choice: " choice
}

# Funzione per lanciare un modulo
run_module() {
    MODULE_PATH="$MODULES_DIR/$1/module.sh"
    if [[ -f "$MODULE_PATH" ]]; then
        bash "$MODULE_PATH"
    else
        echo "  ❌ Modul $1 not found!"
    fi
    echo
    read -p "   Press ENTER to continue..." _
}

# Ciclo principale del menu
while true; do
    show_menu
    case "$choice" in
        1) run_module base_package ;;
        2) run_module nvim ;;
        3) run_module i3 ;;
        4) run_module qemu ;;
        5) 
            run_module base_package
            run_module nvim
            run_module i3
            run_module qemu
            ;;
        0) 
            echo "  Exit..."
            exit 0 ;;
        *) 
            echo "❌ Scelta non valida!"
            sleep 1 ;;
    esac
done

