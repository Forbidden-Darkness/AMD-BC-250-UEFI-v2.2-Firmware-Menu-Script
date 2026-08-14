#!/usr/bin/env bash

clear
# Color definitions
RED='\033[0;31m'
B_RED='\033[1;31m'    # Bold Red for high-visibility Red Pill elements
GREEN='\033[0;32m'
B_GREEN='\033[1;32m'  # Bold Green for verified/active status
YELLOW='\033[1;33m'
B_BLUE='\033[1;34m'   # Bold Blue for high-visibility Blue Pill elements
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

# Helper function to close the terminal emulator process directly
close_terminal() {
    local parent_pid=$PPID
    while [[ $parent_pid -gt 1 ]]; do
        local proc_name
        proc_name=$(ps -o comm= -p "$parent_pid" 2>/dev/null)
        case "$proc_name" in
            konsole|gnome-terminal*|xterm|alacritty|kitty|xfce4-terminal|tilix|ptyxis)
                kill -9 "$parent_pid" 2>/dev/null
                break
                ;;
        esac
        parent_pid=$(ps -o ppid= -p "$parent_pid" 2>/dev/null | tr -d ' ')
    done
    exit 0
}

# Ensure the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "[-] This script must be run as root (sudo)."
   exec sudo "$0" "$@"
fi

# Determine script location
CURRENT_SCRIPT_PATH=$(readlink -f "${BASH_SOURCE[0]:-$0}")
CURRENT_DIR=$(dirname "$CURRENT_SCRIPT_PATH")

# Determine actual user and home paths when invoked via sudo
REAL_USER=${SUDO_USER:-$USER}
USER_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)
INSTALL_DIR="${USER_HOME}/Reboot-to-UEFI"
COPIED_SCRIPT="${INSTALL_DIR}/reboot-uefi.sh"

DESKTOP_DIR="${USER_HOME}/Desktop"
APP_MENU_DIR="${USER_HOME}/.local/share/applications"
DESKTOP_FILE="${DESKTOP_DIR}/reboot-uefi.desktop"
APP_MENU_FILE="${APP_MENU_DIR}/reboot-uefi.desktop"

# Check if script is running from the installed directory
IS_INSTALLED=false
if [[ "$(basename "$CURRENT_DIR")" == "Reboot-to-UEFI" ]]; then
    IS_INSTALLED=true
fi

# Function to handle extracting 7z archive to USB root
extract_7z_to_usb() {
    echo ""
    echo -e "${YELLOW}==========================================${NC}"
    echo -e "${YELLOW}      EXTRACT 7Z ARCHIVE TO USB ROOT      ${NC}"
    echo -e "${YELLOW}==========================================${NC}"

    # Check for 7z tools
    SEVENZIP_BIN=""
    if command -v 7z &>/dev/null; then
        SEVENZIP_BIN="7z"
    elif command -v 7za &>/dev/null; then
        SEVENZIP_BIN="7za"
    else
        echo -e "${BIRed}[-] Error: '7z' or '7za' command not found. Please install p7zip/7-zip.${NC}"
        read -rp "Press Enter to return to main menu..."
        return 1
    fi

    # Find .7z files in CURRENT_DIR or pwd
    mapfile -t ARCHIVES < <(find "$CURRENT_DIR" -maxdepth 1 -type f -iname "*.7z" 2>/dev/null)

    if [[ ${#ARCHIVES[@]} -eq 0 ]]; then
        # Fallback search current working directory
        mapfile -t ARCHIVES < <(find "." -maxdepth 1 -type f -iname "*.7z" 2>/dev/null)
    fi

    if [[ ${#ARCHIVES[@]} -eq 0 ]]; then
        echo -e "${BIRed}[-] No .7z files found in current directory.${NC}"
        read -rp "Press Enter to return to main menu..."
        return 1
    fi

    SELECTED_ARCHIVE=""
    if [[ ${#ARCHIVES[@]} -eq 1 ]]; then
        SELECTED_ARCHIVE="${ARCHIVES[0]}"
        echo -e "${BIGreen}[+] Found archive: $(basename "$SELECTED_ARCHIVE")${NC}"
    else
        echo -e "${YELLOW}Multiple .7z files found. Select one:${NC}"
        for i in "${!ARCHIVES[@]}"; do
            echo -e "  ${CYAN}$((i+1)))${NC} $(basename "${ARCHIVES[$i]}")"
        done
        read -rp $'\e[1;33mSelect archive number: \e[0m' arch_choice
        if [[ "$arch_choice" =~ ^[0-9]+$ ]] && (( arch_choice >= 1 && arch_choice <= ${#ARCHIVES[@]} )); then
            SELECTED_ARCHIVE="${ARCHIVES[$((arch_choice-1))]}"
        else
            echo "[-] Invalid selection. Returning..."
            sleep 1
            return 1
        fi
    fi

    echo ""
    echo -e "${YELLOW}Available Storage Devices (Look for USB drives):${NC}"
    lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS,LABEL | grep -E "sd|nvme|mmcblk"
    echo ""
    read -rp $'\e[1;33mEnter target partition device (e.g., sdb1 or sdc1): \e[0m' target_dev

    # Clean input name
    target_dev=$(echo "$target_dev" | sed 's|/dev/||g')

    if [[ ! -b "/dev/$target_dev" ]]; then
        echo -e "${BIRed}[-] Invalid device block /dev/$target_dev${NC}"
        read -rp "Press Enter to return to main menu..."
        return 1
    fi

    # Determine Mount Point
    TARGET_MOUNT=$(lsblk -no MOUNTPOINT "/dev/$target_dev" | head -n 1)
    TEMP_MOUNTED=false

    if [[ -z "$TARGET_MOUNT" ]]; then
        TARGET_MOUNT="/mnt/usb_target_root"
        mkdir -p "$TARGET_MOUNT"
        echo -e "${YELLOW}[+] Mounting /dev/$target_dev to $TARGET_MOUNT...${NC}"
        if ! mount "/dev/$target_dev" "$TARGET_MOUNT"; then
            echo -e "${BIRed}[-] Failed to mount /dev/$target_dev${NC}"
            read -rp "Press Enter to return to main menu..."
            return 1
        fi
        TEMP_MOUNTED=true
    fi

    echo ""
    echo -e "${YELLOW}[!] Confirm extraction of '${SELECTED_ARCHIVE}' to '${TARGET_MOUNT}' (USB Root)${NC}"
    read -rp $'\e[1;31mAre you sure? (y/N): \e[0m' confirm_ext
    if [[ "$confirm_ext" =~ ^[Yy]$ ]]; then
        echo -e "${BIGreen}[+] Extracting files to USB Root...${NC}"
        "$SEVENZIP_BIN" x "$SELECTED_ARCHIVE" -o"$TARGET_MOUNT" -y

        sync
        echo -e "${BIGreen}[+] Extraction complete! Changes flushed to USB.${NC}"
    else
        echo "[-] Extraction canceled."
    fi

    # Cleanup temp mount if created
    if [[ "$TEMP_MOUNTED" == true ]]; then
        umount "$TARGET_MOUNT"
        rmdir "$TARGET_MOUNT" 2>/dev/null
    fi

    read -rp "Press Enter to return to main menu..."
}

# Function to handle creating shortcuts
create_shortcuts() {
    echo ""
    echo -e "${YELLOW}Where would you like to create the shortcut?${NC}"
    echo -e "${YELLOW}1) Desktop Only${NC}"
    echo -e "${YELLOW}2) Start / Application Menu Only (Utilities)${NC}"
    echo -e "${YELLOW}3) Both Desktop and Start Menu${NC}"
    echo -e "${YELLOW}4) Cancel (Return to Main Menu)${NC}"
    read -rp $'\e[1;33mEnter choice [1-4]: \e[0m' shortcut_choice

    case "$shortcut_choice" in
        1|2|3)
            # Create directory and copy script
            mkdir -p "$INSTALL_DIR"
            cp "$CURRENT_SCRIPT_PATH" "$COPIED_SCRIPT"

            # Set permissions and ownership on installed files
            chmod -R 755 "$INSTALL_DIR"
            chown -R "$REAL_USER":"$REAL_USER" "$INSTALL_DIR"

            DESKTOP_CONTENT="[Desktop Entry]
Version=1.0
Type=Application
Name=Reboot to UEFI
Comment=Reboot system into UEFI firmware or select boot options
Exec=konsole -e sudo \"$COPIED_SCRIPT\"
Icon=system-reboot
Terminal=false
Categories=System;Utility;"

            echo -e "${BIGreen}[+] Folder created at: ${INSTALL_DIR}${NC}"
            echo -e "${BIGreen}[+] Script copied to: ${COPIED_SCRIPT}${NC}"

            # Option 1 or 3: Install Desktop Shortcut
            if [[ "$shortcut_choice" == "1" || "$shortcut_choice" == "3" ]]; then
                if [[ -d "$DESKTOP_DIR" ]]; then
                    echo "$DESKTOP_CONTENT" > "$DESKTOP_FILE"
                    chmod +x "$DESKTOP_FILE"
                    chown "$REAL_USER":"$REAL_USER" "$DESKTOP_FILE"

                    if command -v gio &> /dev/null; then
                        sudo -u "$REAL_USER" gio trust "$DESKTOP_FILE" 2>/dev/null
                    fi
                    echo -e "${BIGreen}[+] Desktop shortcut created at: ${DESKTOP_FILE}${NC}"
                else
                    echo "[-] Warning: Desktop directory not found at $DESKTOP_DIR"
                fi
            fi

            # Option 2 or 3: Install Start / Application Menu Shortcut
            if [[ "$shortcut_choice" == "2" || "$shortcut_choice" == "3" ]]; then
                mkdir -p "$APP_MENU_DIR"
                chown "$REAL_USER":"$REAL_USER" "$APP_MENU_DIR"

                echo "$DESKTOP_CONTENT" > "$APP_MENU_FILE"
                chmod +x "$APP_MENU_FILE"
                chown "$REAL_USER":"$REAL_USER" "$APP_MENU_FILE"

                if command -v update-desktop-database &> /dev/null; then
                    sudo -u "$REAL_USER" update-desktop-database "$APP_MENU_DIR" 2>/dev/null
                fi
                echo -e "${BIGreen}[+] Start/Utilities menu shortcut created at: ${APP_MENU_FILE}${NC}"
            fi

            echo "[+] Done. Closing terminal..."
            sleep 2
            close_terminal
            ;;
        *)
            echo "[-] Returning to Main Menu..."
            sleep 1
            return 0
            ;;
    esac
}

# Function to handle removing shortcuts
remove_shortcuts() {
    echo ""
    echo -e "${YELLOW}Where would you like to remove the shortcut from?${NC}"
    echo -e "${YELLOW}1) Desktop Only${NC}"
    echo -e "${YELLOW}2) Start / Application Menu Only (Utilities)${NC}"
    echo -e "${YELLOW}3) Both Desktop and Start Menu (Full Cleanup)${NC}"
    echo -e "${YELLOW}4) Cancel (Return to Main Menu)${NC}"
    read -rp $'\e[1;33mEnter choice [1-4]: \e[0m' rem_choice

    case "$rem_choice" in
        1|2|3)
            # Remove Desktop Shortcut
            if [[ "$rem_choice" == "1" || "$rem_choice" == "3" ]]; then
                if [[ -f "$DESKTOP_FILE" ]]; then
                    rm -f "$DESKTOP_FILE"
                    echo -e "${BIGreen}[+] Desktop shortcut removed from: ${DESKTOP_FILE}${NC}"
                else
                    echo "[-] Desktop shortcut not found."
                fi
            fi

            # Remove Start / Application Menu Shortcut
            if [[ "$rem_choice" == "2" || "$rem_choice" == "3" ]]; then
                if [[ -f "$APP_MENU_FILE" ]]; then
                    rm -f "$APP_MENU_FILE"
                    if command -v update-desktop-database &> /dev/null; then
                        sudo -u "$REAL_USER" update-desktop-database "$APP_MENU_DIR" 2>/dev/null
                    fi
                    echo -e "${BIGreen}[+] Start/Utilities menu shortcut removed from: ${APP_MENU_FILE}${NC}"
                else
                    echo "[-] Start/Utilities menu shortcut not found."
                fi
            fi

            # Check if BOTH shortcuts are now gone
            if [[ ! -f "$DESKTOP_FILE" && ! -f "$APP_MENU_FILE" ]]; then
                if [[ -d "$INSTALL_DIR" ]]; then
                    rm -rf "$INSTALL_DIR"
                    echo -e "${BIGreen}[+] Installation directory cleaned up from home folder: ${INSTALL_DIR}${NC}"
                fi
            fi

            echo "[+] Done. Closing terminal..."
            sleep 2
            close_terminal
            ;;
        *)
            echo "[-] Returning to Main Menu..."
            sleep 1
            return 0
            ;;
    esac
}

# Main loop
while true; do
    clear
    echo -e "${YELLOW}==========================================${NC}"
    echo -e "${YELLOW}           REBOOT TO UEFI TOOL            ${NC}"
    echo -e "${YELLOW}==========================================${NC}"
    echo -e "${YELLOW}1) UEFI Firmware Setup (Reboot to BIOS)${NC}"
    echo -e "${YELLOW}2) EFI Boot Manager One-Time Boot (efibootmgr)${NC}"
    echo -e "${YELLOW}3) Standard Reboot (Interrupt GRUB manually)${NC}"
    echo -e "${YELLOW}4) Extract Existing .7z File to USB Root${NC}"

    if [[ "$IS_INSTALLED" == false ]]; then
        echo -e "${YELLOW}5) Manage Shortcuts (Create / Remove)${NC}"
        echo -e "${YELLOW}6) Cancel / Exit${NC}"
        echo -e "${YELLOW}------------------------------------------${NC}"
        read -rp $'\e[1;33mEnter your choice [1-6]: \e[0m' choice
    else
        echo -e "${YELLOW}5) Remove Shortcuts${NC}"
        echo -e "${YELLOW}6) Cancel / Exit${NC}"
        echo -e "${YELLOW}------------------------------------------${NC}"
        read -rp $'\e[1;33mEnter your choice [1-6]: \e[0m' choice
    fi

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
            extract_7z_to_usb
            ;;
        5)
            if [[ "$IS_INSTALLED" == false ]]; then
                echo ""
                echo -e "${YELLOW}Shortcut Management:${NC}"
                echo -e "${YELLOW}1) Create Shortcuts${NC}"
                echo -e "${YELLOW}2) Remove Shortcuts${NC}"
                echo -e "${YELLOW}3) Return to Main Menu${NC}"
                read -rp $'\e[1;33mEnter choice [1-3]: \e[0m' manage_choice

                case "$manage_choice" in
                    1) create_shortcuts ;;
                    2) remove_shortcuts ;;
                    3) echo "[-] Returning to Main Menu..."; sleep 1 ;;
                    *) echo "[-] Invalid choice. Returning to Main Menu..."; sleep 1 ;;
                esac
            else
                remove_shortcuts
            fi
            ;;
        6)
            echo "Exiting..."
            close_terminal
            ;;
        *)
            echo "[-] Invalid choice. Please try again."
            sleep 1
            ;;
    esac
done
