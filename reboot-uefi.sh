#!/usr/bin/env bash

clear
# Color definitions
RED='\033[0;31m'
B_RED='\033[1;31m'   # Bold Red for high-visibility Red Pill elements
GREEN='\033[0;32m'
B_GREEN='\033[1;32m' # Bold Green for verified/active status
YELLOW='\033[1;33m'
B_BLUE='\033[1;34m'  # Bold Blue for high-visibility Blue Pill elements
B_VIOLET='\033[1;35m' # Bold Violet for ACPI Fix elements
CYAN='\033[0;36m'
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
NC='\033[0m' # No Color (Reset)

# Ensure the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "[-] This script must be run as root (sudo)."
   exec sudo "$0" "$@"
fi

echo -e "${YELLOW}==========================================${NC}"
echo -e "${YELLOW}          REBOOT TO UEFI TOOL             ${NC}"
echo -e "${YELLOW}==========================================${NC}"
echo -e "${YELLOW}1) UEFI Firmware Setup (Reboot to BIOS)${NC}"
echo -e "${YELLOW}2) EFI Boot Manager One-Time Boot (efibootmgr)${NC}"
echo -e "${YELLOW}3) Standard Reboot (Interrupt GRUB manually)${NC}"
echo -e "${YELLOW}4) Cancel / Exit${NC}"
echo -e "${YELLOW}------------------------------------------${NC}"

read -rp $'\e[1;33mEnter your choice [1-4]: \e[0m' choice

case $choice in
    1)
        echo "[+] Rebooting into UEFI firmware settings..."
        echo "[!] Once in BIOS, use 'Boot Override' to select your USB."
        sleep 2
        systemctl reboot --firmware-setup
        ;;
    2)
        if ! command -v efibootmgr &> /dev/null; then
            echo "[-] Error: 'efibootmgr' is not installed or this is not a UEFI system."
            exit 1
        fi

        echo ""
        echo "Current EFI Boot Entries:"
        efibootmgr
        echo ""
        read -rp "Enter the hex number of your USB boot entry (e.g., 0003): " boot_num

        if [[ -n "$boot_num" ]]; then
            echo "[+] Setting next boot target to Boot$boot_num..."
            efibootmgr --bootnext "$boot_num"
            echo "[+] Rebooting now..."
            sleep 2
            systemctl reboot
        else
            echo "[-] Invalid entry. Aborting."
            exit 1
        fi
        ;;
    3)
        echo "[+] Initiating standard reboot."
        echo "[!] Tap ESC or SHIFT immediately during startup to access GRUB/Boot Menu."
        sleep 2
        systemctl reboot
        ;;
    4)
        echo "Exiting."
        exit 0
        ;;
    *)
        echo "[-] Invalid choice. Please run the script again and select 1-4."
        exit 1
        ;;
esac
