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

# ==============================================================================
# UPGRADED: INTEGRATED THE THEMATIC VISUAL TRANSITION ENGINES
# ==============================================================================
type_prompt() {
    local text="$1"
    local delay="${2:-0.03}"
    for (( i=0; i<${#text}; i++ )); do
        echo -ne "${text:$i:1}"
        sleep "$delay"
    done
}

blink_cursor() {
    local prompt_text="$1"
    echo -ne "$prompt_text"
    for i in {1..3}; do
        echo -ne "\033[5m█\033[0m"
        sleep 0.5
        echo -ne "\b "
        sleep 0.5
    done
    echo ""
}

matrix_melt_clear() {
    local lines; lines=$(tput lines)
    for ((i=0; i<lines; i++)); do
        echo "" # Pushes the terminal buffer down
        sleep 0.01
    done
    clear
}

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
CURRENT_SCRIPT_PATH=$(readlink -f "${BASH_SOURCE:-$0}")
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

# ==============================================================================
# UPGRADED MAP LAYER: PURE RGB HARDWARE INITIALIZATION WELCOME BANNER
# ==============================================================================
clear
echo -e "\033[38;2;0;255;0m  ╔══════════════════════════════════════════════════════════════════════════╗\033[0m"
echo -e "\033[38;2;0;255;0m  ║                                                                          ║\033[0m"
echo -e "\033[38;2;0;255;0m  ║                     █ █ █ █▀▀ █   █▀▀ █▀█ █▄█ █▀▀                        ║\033[0m"
echo -e "\033[38;2;0;255;0m  ║                     ▀▄▀▄▀ ██▄ █▄▄ █▄▄ █▄█ █ █ ██▄                        ║\033[0m"
echo -e "\033[38;2;0;255;0m  ║                                                                          ║\033[0m"
echo -e "\033[38;2;0;255;0m  ╚══════════════════════════════════════════════════════════════════════════╝\033[0m"
echo ""
# FIX: Hardcoded to 24-bit True Color RGB inside the echo command so every typed letter is strictly absolute matrix green
type_prompt() {
    local text="$1"
    local delay="${2:-0.03}"
    for (( i=0; i<${#text}; i++ )); do
        # Injects the matrix green true color right behind every character block seamlessly
        echo -ne "\033[38;2;0;255;0m${text:$i:1}\033[0m"
        sleep "$delay"
    done
}

# The text now types out in crisp, beautiful matrix green automatically without code bleed!
type_prompt "  Establishing Firmware Authorization.... " 0.03
blink_cursor ""
echo ""
type_prompt "  exploiting system entry " 0.03
blink_cursor ""

type_prompt "  injecting exploit.... " 0.05
blink_cursor ""

type_prompt "  system has been pwned, root access has been granted.... " 0.03
blink_cursor ""
echo ""
type_prompt "  mapping system block registers " 0.03
blink_cursor ""

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
        type_prompt "Press Enter to return to main menu..." 0.03
        read -r
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
        type_prompt "Press Enter to return to main menu..." 0.03
        read -r
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
        # FIX: Removed manual color code string from prompt input quotes
        type_prompt "Select archive number: " 0.03
        read -r arch_choice
        if [[ "$arch_choice" =~ ^[0-9]+$ ]] && (( arch_choice >= 1 && arch_choice <= ${#ARCHIVES[@]} )); then
            SELECTED_ARCHIVE="${ARCHIVES[$((arch_choice-1))]}"
        else
            echo "[-] Invalid selection. Returning..."
            sleep 1
            return 1
        fi
    fi

    # ==============================================================================
    # DYNAMIC HARDWARE MONITORS: LIVE PLUG DETECTOR SCANNER ENGINE
    # ==============================================================================
    echo ""
    echo -e "${YELLOW}Available Storage Devices (Look for USB drives):${NC}"
    lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS,LABEL | grep -E "sd|nvme|mmcblk"
    echo ""

    echo -e "${CYAN}[ℹ] Scanning system and listening for USB storage target...${NC}"
    echo -e "${DIM}    Press Ctrl+C to cancel and exit back to main dashboard.${RESET}"
    echo ""

    # Store the exact system storage snapshot prior to running user hotplug evaluations
    local initial_devices; initial_devices=$(lsblk -no NAME | tr -d ' ' | grep -E "sd|nvme|mmcblk" | sort | uniq)
    local target_dev=""

    # ==============================================================================
    # FIX: ALWAYS FORCE SELECTION IF PRE-EXISTING USB DEVICES ARE PRESENT
    # ==============================================================================
    mapfile -t usb_parts < <(lsblk -lno NAME,TYPE,TRAN 2>/dev/null | grep -E "part" | grep -v -E "nvme|mmcblk" | awk '{print $1}')

    if [[ ${#usb_parts[@]} -gt 0 ]]; then
        echo -e "${YELLOW}[!] Connected storage partitions discovered. Select target payload destination:${NC}"
        echo -e "${DIM}  -------------------------------------------------------------${RESET}"
        for i in "${!usb_parts[@]}"; do
            local p_name="${usb_parts[$i]}"
            local p_size; p_size=$(lsblk -no SIZE "/dev/$p_name" 2>/dev/null | head -n 1 | tr -d ' ')
            local p_label; p_label=$(lsblk -no LABEL "/dev/$p_name" 2>/dev/null | head -n 1 | tr -d ' ')
            local p_fs; p_fs=$(lsblk -no FSTYPE "/dev/$p_name" 2>/dev/null | head -n 1 | tr -d ' ')
            echo -e "    ${CYAN}$((i+1)))${NC} /dev/${p_name} [${p_size}] ${DIM}(Format: ${p_fs:-Unknown} - Label: ${p_label:-No Label})${RESET}"
        done
        echo -e "    ${CYAN}s)${NC} Skip and stay in live plug hot-detector listener mode"
        echo -e "${DIM}  -------------------------------------------------------------${RESET}"

        # FIX: Removed manual color code string from partition choice prompt quotes
        type_prompt "  Select partition option index number or \"s\": " 0.03
        read -r user_index

        if [[ "$user_index" =~ ^[0-9]+$ ]] && (( user_index >= 1 && user_index <= ${#usb_parts[@]} )); then
            target_dev="${usb_parts[$((user_index-1))]}"
        else
            echo "[-] Manual selection bypassed. Slipping into active live-plug listener..."
            target_dev=""
        fi
    fi

    # ==============================================================================
    # FALLBACK MODE: START LIVE HOTPLUG DETECTOR TIMER IF SELECTION WAS SKIPPED
    # ==============================================================================
    if [[ -z "$target_dev" ]]; then
        # Draw the prompt label exactly ONCE up front so it never loops horizontally
        echo -ne "  Enter target partition device manually OR plug in USB now: "

        while true; do
            # FIX: The read prompt is now empty ("") so it monitors your keystrokes silently
            if read -t 1 -r input_dev; then
                target_dev="$input_dev"
                break
            fi

            # Scan hardware topography tables to determine if a tracking profile state change occurs
            local current_devices; current_devices=$(lsblk -no NAME | tr -d ' ' | grep -E "sd|nvme|mmcblk" | sort | uniq)
            local diff_dev; diff_dev=$(comm -13 <(echo "$initial_devices") <(echo "$current_devices") | grep -v -E "[0-9]$" | head -n 1)

            if [[ -n "$diff_dev" ]]; then
                # Safe fallback conversion targeting partition 1
                diff_dev="${diff_dev}1"

                echo -e "\n\n${BIGreen}[+!+] NEW HOT-PLUGGED HARDWARE DETECTED: /dev/${diff_dev}${NC}"
                echo -e "${YELLOW}------------------------------------------------------------${NC}"
                lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS,LABEL "/dev/${diff_dev%[0-9]}" 2>/dev/null
                echo -e "${YELLOW}------------------------------------------------------------${NC}"

                target_dev="$diff_dev"
                break
            fi
        done
    fi

    # Clean input name configuration metrics
    target_dev=$(echo "$target_dev" | sed 's|/dev/||g')

    if [[ ! -b "/dev/$target_dev" ]]; then
        echo -e "${BIRed}[-] Invalid device block /dev/$target_dev${NC}"
        type_prompt "Press Enter to return to main menu..." 0.03
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
            type_prompt "Press Enter to return to main menu..." 0.03
            return 1
        fi
        TEMP_MOUNTED=true
    fi

    echo ""
    echo -e "${YELLOW}[!] Confirm extraction of '${SELECTED_ARCHIVE}' to '${TARGET_MOUNT}' (USB Root)${NC}"
    # FIX: Removed manual color code string from confirmation choice prompt quotes
    type_prompt "Are you sure? (y/N): " 0.03
    read -r confirm_ext
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

    type_prompt "Press Enter to return to main menu..." 0.03
    read -r
}

# Function to handle efibootmgr to USB
efibootmg() {
    echo ""
    echo -e "${YELLOW}==========================================${NC}"
    echo -e "${YELLOW}      EFI Boot Manager One-Time Boot      ${NC}"
    echo -e "${YELLOW}==========================================${NC}"

    if ! command -v efibootmgr &> /dev/null; then
        echo "[-] Error: 'efibootmgr' is not installed or this is not a UEFI system."
        exit 1
    fi

    echo ""
    echo "Current EFI Boot Entries:"
    efibootmgr
    echo ""

    echo -e "${CYAN}[ℹ] Scanning system and listening for USB boot drive...${NC}"
    echo -e "${DIM}    Press Ctrl+C to cancel and exit back to main dashboard.${RESET}"
    echo ""

    # Capture initial system snapshot baseline
    local initial_devices; initial_devices=$(lsblk -no NAME | tr -d ' ' | grep -E "sd|nvme|mmcblk" | sort | uniq)
    local boot_num=""
    local target_disk=""
    local part_num="1"

    # ==============================================================================
    # FIX: ALWAYS FORCE SELECTION IF USB STORAGE DEVICES ARE PRESENT
    # ==============================================================================
    mapfile -t usb_drives < <(lsblk -dno NAME,RM,TRAN 2>/dev/null | grep -E "sd" | grep -E "1|usb" | awk '{print $1}')

    if [[ ${#usb_drives[@]} -gt 0 ]]; then
        local chosen_usb=""

        # FIX: Auto-selection has been removed. You will always be prompted to choose.
        echo -e "${YELLOW}[!] Active USB hardware profiles discovered. Select your boot target:${NC}"
        echo -e "${DIM}  -------------------------------------------------------------${RESET}"
        for i in "${!usb_drives[@]}"; do
            local d_name="${usb_drives[$i]}"
            local d_size; d_size=$(lsblk -dno SIZE "/dev/$d_name" 2>/dev/null | tr -d ' ')
            local d_label; d_label=$(lsblk -dno LABEL "/dev/$d_name" | head -n 1 | tr -d ' ')
            local d_vendor; d_label_vendor=$(lsblk -dno VENDOR "/dev/$d_name" 2>/dev/null | head -n 1 | tr -d ' ')
            echo -e "    ${CYAN}$((i+1)))${NC} /dev/${d_name} [${d_size}] ${DIM}(${d_label_vendor:-USB Drive} - Label: ${d_label:-No Label})${RESET}"
        done
        echo -e "    ${CYAN}s)${NC} Skip and stay in live plug hot-detector listener mode"
        echo -e "${DIM}  -------------------------------------------------------------${RESET}"

        # FIX: Stripped the manual color string from prompt quotes to prevent double-color text logs
        type_prompt "  Select device index number or \"s\" to skip: " 0.03
        read -r usb_index

        if [[ "$usb_index" =~ ^[0-9]+$ ]] && (( usb_index >= 1 && usb_index <= ${#usb_drives[@]} )); then
            chosen_usb="${usb_drives[$((usb_index-1))]}"
        else
            echo "[-] Manual selection bypassed. Transitioning to hotplug listener layer..."
            chosen_usb=""
        fi

        if [[ -n "$chosen_usb" ]]; then
            local active_part; active_part=$(lsblk -no NAME "/dev/${chosen_usb}" | grep -E "[0-9]$" | head -n 1 | tr -d ' ')
            if [[ -n "$active_part" ]]; then
                target_disk="/dev/${chosen_usb}"
                part_num=$(lsblk -no PARTN "/dev/${active_part}" 2>/dev/null | tr -d ' ')
                [[ -z "$part_num" ]] && part_num="1"
            fi
        fi
    fi
    # ==============================================================================
    # FALLBACK MODE: START LIVE HOTPLUG DETECTOR IF SELECTION WAS SKIPPED OR EMPTY
    # ==============================================================================
    if [[ -z "$target_disk" ]]; then
        echo -ne "Enter the hex number manually OR plug in your USB drive now: "
        while true; do
            if read -t 1 -r input_num; then
                boot_num="$input_num"
                break
            fi

            local current_devices; current_devices=$(lsblk -no NAME | tr -d ' ' | grep -E "sd|nvme|mmcblk" | sort | uniq)
            local diff_dev; diff_dev=$(comm -13 <(echo "$initial_devices") <(echo "$current_devices") | grep -v -E "[0-9]$" | head -n 1)

            if [[ -n "$diff_dev" ]]; then
                echo -e "\n\n${BIGreen}[+!+] NEW HOT-PLUGGED HARDWARE DETECTED: /dev/${diff_dev}${NC}"
                sleep 1.5

                local active_part; active_part=$(lsblk -no NAME "/dev/${diff_dev}" | grep -E "[0-9]$" | head -n 1 | tr -d ' ')
                [[ -z "$active_part" ]] && active_part="${diff_dev}1"

                target_disk="/dev/${diff_dev}"
                part_num=$(lsblk -no PARTN "/dev/${active_part}" 2>/dev/null | tr -d ' ')
                [[ -z "$part_num" ]] && part_num="1"
                break
            fi
        done
    fi

    # ==============================================================================
    # CORE LIVE NVRAM INJECTION UTILITY
    # ==============================================================================
    if [[ -n "$target_disk" && -z "$boot_num" ]]; then
        echo -e "${CYAN}[+] Overriding motherboard block table... Injecting NVRAM path context...${NC}"

        sudo efibootmgr -B -L "USB Hotplug Boot Bypass" &>/dev/null
        sudo efibootmgr -c -d "$target_disk" -p "$part_num" -L "USB Hotplug Boot Bypass" -l "\\EFI\\BOOT\\BOOTX64.EFI" &>/dev/null

        boot_num=$(efibootmgr | grep "USB Hotplug Boot Bypass" | head -n 1 | cut -d' ' -f1 | tr -d 'Boot*' | tr -d ':')

        if [[ -n "$boot_num" ]]; then
            echo -e "${BIGreen}[+] Hardware successfully injected! New UEFI Slot Target: Boot${boot_num}${NC}"
        else
            echo -e "${YELLOW}[!] Motherboard secure NVRAM locked. Reverting to manual entry selection...${NC}"
            echo -ne "Enter target hex number manually: "
            read -r manual_num
            boot_num="$manual_num"
        fi
    fi

    # ==============================================================================
    # FIX: INTERACTIVE CONFIRMATION GATE (Guarantees one-time boot order enforcement)
    # ==============================================================================
    if [[ -n "$boot_num" ]]; then
        echo ""
        echo -e "${YELLOW}==================================================${NC}"
        echo -e "${YELLOW}       READY TO INITIATE UEFI BOOT OVERRIDE       ${NC}"
        echo -e "${YELLOW}--------------------------------------------------${NC}"
        echo -e " Target Registry: Boot${boot_num}"
        echo -e " Target Device  : ${target_disk:-Manual Input}"
        echo -e "${YELLOW}==================================================${NC}"

        # FIX: Stripped the manual color string from quotes to prevent double-color text logs
        type_prompt " Do you want to reboot into this device now? (y/N): " 0.03
        read -r confirm_reboot

        if [[ "$confirm_reboot" =~ ^[Yy]$ ]]; then
            # 1. Grab your original default permanent boot order before making changes
            local current_order; current_order=$(efibootmgr | grep "^BootOrder:" | cut -d' ' -f2)

            # 2. Extract your primary Bazzite OS boot slot index token (e.g. 0000)
            local bazzite_slot; bazzite_slot=$(efibootmgr | grep -E "Bazzite|Fedora" | head -n 1 | cut -d' ' -f1 | tr -d 'Boot*' | tr -d ':')

            # 3. Fallback: If no Bazzite index string is parsed, default to your active slot 0003
            [[ -z "$bazzite_slot" ]] && bazzite_slot="0003"

            echo -e "${CYAN}[+] Locking Bazzite (${bazzite_slot}) as permanent system target...${NC}"

            # 4. Re-enforce your permanent order table to keep your OS at index 0
            if [[ -n "$current_order" ]]; then
                # Strip out the flash drive slot if it's already in the permanent list
                local cleaned_order; cleaned_order=$(echo "$current_order" | sed "s/${boot_num},//g; s/,${boot_num}//g")
                sudo efibootmgr -o "${bazzite_slot},${cleaned_order}" &>/dev/null
            else
                sudo efibootmgr -o "${bazzite_slot}" &>/dev/null
            fi

            # 5. Execute the temporary, isolated one-time boot override
            echo "[+] Setting next boot target to Boot$boot_num..."
            sudo efibootmgr --bootnext "$boot_num"

            echo "[+] Rebooting now..."
            sleep 2
            systemctl reboot
        else
            echo -e "${YELLOW}[-] Reboot cancelled. Returning cleanly to main menu options...${NC}"
            sleep 2
            return 0
        fi
    else
        echo "[-] Invalid entry or selection skipped. Aborting."
        sleep 1.5
    fi
}

# Function to handle creating shortcuts
create_shortcuts() {
    echo ""
    # KEEP: Static options remain cleanly colored and perfectly numbered
    echo -e "\033[38;2;0;255;0mWhere would you like to create the shortcut?\033[0m"
    echo -e "\033[38;2;0;255;0m1) Desktop Only\033[0m"
    echo -e "\033[38;2;0;255;0m2) Start / Application Menu Only (Utilities)\033[0m"
    echo -e "\033[38;2;0;255;0m3) Both Desktop and Start Menu\033[0m"
    echo -e "\033[38;2;0;255;0m4) Cancel (Return to Main Menu)\033[0m"

    # FIX: Stripped the manual color string from quotes to prevent double-color text logs
    type_prompt "Enter choice [1-4]: " 0.03
    read -r shortcut_choice

    case "$shortcut_choice" in
        1|2|3)
            # Create installation directory infrastructure
            mkdir -p "$INSTALL_DIR"

            # Copy the script asset core layer
            cp "$CURRENT_SCRIPT_PATH" "$COPIED_SCRIPT"

            # ==============================================================================
            # NEW PROVISIONING LAYER: LIVE SEARCH & TARGETED COPY OF RELEASE .7Z PACKAGE
            # ==============================================================================
            # Use failglobe suppression to find any matching packages in the active script path context
            local archive_match
            mapfile -t archive_match < <(find "$CURRENT_DIR" -maxdepth 1 -type f -name "release-0*.7z" 2>/dev/null)

            if [[ ${#archive_match[@]} -eq 0 ]]; then
                # Fallback: search your current active working directory shell state
                mapfile -t archive_match < <(find "." -maxdepth 1 -type f -name "release-0*.7z" 2>/dev/null)
            fi

            if [[ ${#archive_match[@]} -gt 0 ]]; then
                # Select the absolute latest alphabet matching package entry target
                local source_archive="${archive_match[0]}"
                local target_archive_name; target_archive_name=$(basename "$source_archive")

                echo -e "${CYAN}[+] Staging payload package file migration context...${NC}"
                cp "$source_archive" "${INSTALL_DIR}/${target_archive_name}"
                echo -e "${BIGreen}[+] Payload archive successfully copied: ${target_archive_name}${NC}"
            else
                echo -e "${YELLOW}[!] Warning: No 'release-0*.7z' package bundle found in source directories.${NC}"
                echo -e "${DIM}    You will need to place the .7z package into ${INSTALL_DIR} manually later.${RESET}"
            fi

            # Set robust standard permissions and execution ownership across installed files
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
    # KEEP: Static options remain cleanly colored and perfectly numbered
    echo -e "\033[38;2;0;255;0mWhere would you like to remove the shortcut from?\033[0m"
    echo -e "\033[38;2;0;255;0m1) Desktop Only\033[0m"
    echo -e "\033[38;2;0;255;0m2) Start / Application Menu Only (Utilities)\033[0m"
    echo -e "\033[38;2;0;255;0m3) Both Desktop and Start Menu (Full Cleanup)\033[0m"
    echo -e "\033[38;2;0;255;0m4) Cancel (Return to Main Menu)\033[0m"

    # FIX: Stripped the manual color string from quotes to prevent double-color text logs
    type_prompt "Enter choice [1-4]: " 0.03
    read -r rem_choice

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
    # UPGRADED: Replaced standard abrupt clear with the thematic screen dissolve melt
    matrix_melt_clear

    # FIX: Center-balanced "NEOBOOT INTERFACE" (17 chars) inside your 60-character true color green panel frame
    echo -e "\033[38;2;0;255;0m  ╔══════════════════════════════════════════════════════════╗\033[0m"
    echo -e "\033[38;2;0;255;0m  ║                                                          ║\033[0m"
    echo -e "\033[38;2;0;255;0m  ║                    FIRMWARE INTERFACE                    ║\033[0m"
    echo -e "\033[38;2;0;255;0m  ║                                                          ║\033[0m"
    echo -e "\033[38;2;0;255;0m  ╚══════════════════════════════════════════════════════════╝\033[0m"
    # RESTORED: All your original menu option numbers are back in place!
    echo -e "\033[38;2;0;255;0m   1)\033[0m UEFI Firmware Setup (Reboot to BIOS)"
    echo -e "\033[38;2;0;255;0m   2)\033[0m EFI Boot Manager One-Time Boot (efibootmgr)"
    echo -e "\033[38;2;0;255;0m   3)\033[0m Standard Reboot (Interrupt GRUB manually)"
    echo -e "\033[38;2;0;255;0m   4)\033[0m Extract Existing .7z File to USB Root"

    if [[ "$IS_INSTALLED" == false ]]; then
        echo -e "\033[38;2;0;255;0m   5)\033[0m Manage Shortcuts (Create / Remove)"
        echo -e "\033[38;2;0;255;0m   6)\033[0m Cancel / Exit"
        echo -e "\033[38;2;0;255;0m  ────────────────────────────────────────────────────────────\033[0m"
        type_prompt "  Select an option [1-6]: " 0.03
        read -r choice
    else
        echo -e "\033[38;2;0;255;0m   5)\033[0m Remove Shortcuts"
        echo -e "\033[38;2;0;255;0m   6)\033[0m Cancel / Exit"
        echo -e "\033[38;2;0;255;0m  ────────────────────────────────────────────────────────────\033[0m"
        type_prompt "  Select an option [1-6]: " 0.03
        read -r choice
    fi


    case $choice in
        1)
            echo "[+] Rebooting into UEFI firmware settings..."
            echo "[!] Once in BIOS, use 'Boot Override' to select your USB."
            sleep 2
            systemctl reboot --firmware-setup
            ;;
        2)
            efibootmg
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
        5)            if [[ "$IS_INSTALLED" == false ]]; then
                echo ""
                # KEEP: Static options remain cleanly colored and perfectly numbered
                echo -e "\033[38;2;0;255;0mShortcut Management:\033[0m"
                echo -e "\033[38;2;0;255;0m1) Create Shortcuts\033[0m"
                echo -e "\033[38;2;0;255;0m2) Remove Shortcuts\033[0m"
                echo -e "\033[38;2;0;255;0m3) Return to Main Menu\033[0m"

                # FIX: Stripped the manual color string from quotes to prevent double-color text logs
                type_prompt "Enter choice [1-3]: " 0.03
                read -r manage_choice

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
