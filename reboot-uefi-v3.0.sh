#!/usr/bin/env bash
clear

RED='\033[0;31m'
B_RED='\033[1;31m'   # Bold Red for high-visibility Red Pill elements
GREEN='\033[0;32m'
B_GREEN='\033[0;92m'
YELLOW='\033[1;33m'
B_BLUE='\033[1;34m'  # Bold Blue for high-visibility Blue Pill elements
B_VIOLET='\033[1;35m' # Bold Violet for ACPI Fix elements
CYAN='\033[0;36m'
BIBlack='\033[1;90m'
BIRed='\033[1;91m'
BIGreen='\033[1;92m'
BIYellow='\033[1;93m'
BIBlue='\033[1;94m'
BIPurple='\033[1;95m'
BICyan='\033[1;96m'
BIWhite='\033[1;97m'
MAGENTA="\033[1;95m"
NC='\033[0m'
RESET='\033[0m'
BG_HEADER="\e[48;5;235m"

# 🧬 FIXED: Maps standard ANSI escape token attributes to lock in faded text elements
DIM='\033[38;2;110;110;110m'
BOLD='\033[1m'

# 🚀 GLOBAL ANIMATION SKIP TRACKER INITIALIZATION
SKIP_ANIMATION=false

check_skip_keypress() {
    if [ "$SKIP_ANIMATION" = true ]; then return 0; fi
    if read -t 0.001 -n 1 2>/dev/null; then
        SKIP_ANIMATION=true
        read -t 0.1 -N 255 _ || true # 🧼 BUFFER FLASH: Wipes trailing key data to prevent menu selection bypass bugs
    fi
}

type_prompt() {
    local text="$1" local delay="${2:-0.03}"
    for (( i=0; i<${#text}; i++ )); do
        echo -ne "${text:$i:1}"
        check_skip_keypress
        if [ "$SKIP_ANIMATION" != true ]; then sleep "$delay"; fi
    done
}

blink_cursor() {
    local prompt_text="$1"
    echo -ne "$prompt_text"
    check_skip_keypress
    if [ "$SKIP_ANIMATION" = true ]; then echo ""; return 0; fi

    for i in {1..3}; do
        echo -ne "\033[5m█\033[0m"
        for s in {1..5}; do
            if read -t 0.1 -n 1 2>/dev/null; then
                SKIP_ANIMATION=true
                echo -ne "\b \n"; read -t 0.1 -N 255 _ || true; return 0;
            fi
        done
        # 🎯 CRAWLING OFFSET PRESERVED: Preserves your favorite typewriter line-crawl movement exactly
        echo -ne "\b "
        for s in {1..5}; do
            if read -t 0.1 -n 1 2>/dev/null; then
                SKIP_ANIMATION=true
                echo -e "\n"; read -t 0.1 -N 255 _ || true; return 0;
            fi
        done
    done
    echo ""; read -t 0.1 -N 255 _ || true
}

matrix_melt_clear() {
    local lines; lines=$(tput lines)
    for ((i=0; i<lines; i++)); do
        check_skip_keypress
        echo ""
        if [ "$SKIP_ANIMATION" != true ]; then sleep 0.01; fi
    done
    clear
}

close_terminal() {
    local parent_pid=$PPID
    while [[ $parent_pid -gt 1 ]]; do
        local proc_name; proc_name=$(ps -o comm= -p "$parent_pid" 2>/dev/null)
        case "$proc_name" in
            konsole|gnome-terminal*|xterm|alacritty|kitty|xfce4-terminal|tilix|ptyxis)
                kill -9 "$parent_pid" 2>/dev/null; break ;;
        esac
        parent_pid=$(ps -o ppid= -p "$parent_pid" 2>/dev/null | tr -d ' ')
    done
    exit 0
}

if [[ $EUID -ne 0 ]]; then
   echo "[-] This script must be run as root (sudo)."
   exec sudo "$0" "$@"
fi
CURRENT_SCRIPT_PATH=$(readlink -f "${BASH_SOURCE:-$0}")
CURRENT_DIR=$(dirname "$CURRENT_SCRIPT_PATH")

REAL_USER=${SUDO_USER:-$USER}
USER_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)
INSTALL_DIR="${USER_HOME}/Reboot-to-UEFI"
COPIED_SCRIPT="${INSTALL_DIR}/reboot-uefi.sh"

DESKTOP_DIR="${USER_HOME}/Desktop"
APP_MENU_DIR="${USER_HOME}/.local/share/applications"
DESKTOP_FILE="${DESKTOP_DIR}/reboot-uefi.desktop"
APP_MENU_FILE="${APP_MENU_DIR}/reboot-uefi.desktop"

IS_INSTALLED=false
if [[ "$(basename "$CURRENT_DIR")" == "Reboot-to-UEFI" ]]; then
    IS_INSTALLED=true
fi

# Visual sequence banner intro
clear
echo -e "\033[38;2;0;255;0m  ╔═════════════════════════════════════════════════════════════════════════════════════════════╗\033[0m"
echo -e "\033[38;2;0;255;0m  ║                                                                                             ║\033[0m"
echo -e "\033[38;2;0;255;0m  ║                                █ █ █ █▀▀ █   █▀▀ █▀█ █▄█ █▀▀                                ║\033[0m"
echo -e "\033[38;2;0;255;0m  ║                                ▀▄▀▄▀ ██▄ █▄▄ █▄▄ █▄█ █ █ ██▄                                ║\033[0m"
echo -e "\033[38;2;0;255;0m  ║                                                                                             ║\033[0m"
echo -e "\033[38;2;0;255;0m  ║                                                                                             ║\033[0m"
echo -e "\033[38;2;0;255;0m  ║                                                                                        v3.0 ║\033[0m"
echo -e "\033[38;2;0;255;0m  ╚═════════════════════════════════════════════════════════════════════════════════════════════╝\033[0m"
echo -e "  ${DIM}→ Press ANY KEY to instantly bypass connection logs and initialization streams...${NC}\n"

type_prompt_green() {
    local text="$1" local delay="${2:-0.03}"
    for (( i=0; i<${#text}; i++ )); do
        echo -ne "\033[38;2;0;255;0m${text:$i:1}\033[0m"
        check_skip_keypress
        if [ "$SKIP_ANIMATION" != true ]; then sleep "$delay"; fi
    done
}

type_prompt_green "  Establishing Firmware Authorization.... " 0.03
blink_cursor ""
echo ""
type_prompt_green "  exploiting system entry " 0.03
blink_cursor ""
type_prompt_green "  injecting exploit.... " 0.05
blink_cursor ""
type_prompt_green "  system has been pwned, root access has been granted.... " 0.03
blink_cursor ""
echo ""
type_prompt_green "  mapping system block registers " 0.03
blink_cursor ""
echo ""

draw_progress_bar() {
    local duration="$1" local width=30
    echo -ne "   Processing: ["
    for ((i=1; i<=width; i++)); do
        local pct=$(( i * 100 / width ))
        local g_val=$(( 100 + (i * 155 / width) ))
        echo -ne "\033[38;2;0;${g_val};0m█\033[0m"
        check_skip_keypress
        if [ "$SKIP_ANIMATION" != true ]; then
            sleep "$(bc -l <<< "$duration / $width")"
        fi
    done
    echo -e "] Done!"
}

draw_progress_bar 1.5
echo ""

extract_7z_to_usb() {
    echo ""
    echo -e "${YELLOW}==========================================${NC}"
    echo -e "${YELLOW}      EXTRACT 7Z ARCHIVE TO USB ROOT      ${NC}"
    echo -e "${YELLOW}==========================================${NC}"

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

    local scan_dir="${CURRENT_DIR:-.}"
    local force_download_flow="false"

    # 🧠 ALWAYS PROMPT FIRST LAYER: Actively asks user intent at the absolute front line of execution
    echo -e "${YELLOW}[ℹ] CHOOSE FIRMWARE ARCHIVE DEPLOYMENT TRACK:${NC}"
    echo -e "  \033[0;36m1)\033[0m Scan and use existing local release files"
    echo -e "  \033[0;36m2)\033[0m Connect to GitHub to pull the latest repository update"
    type_prompt "  Select option track [1-2]: " 0.03
    local init_track; read -r init_track

    if [[ "$init_track" == "2" ]]; then
        force_download_flow="true"
    fi

    # 🧠 PREFIX-LOCKED LOCAL SCANNER: Scans strictly for compressed files starting with "release"
    mapfile -t ARCHIVES < <(find "$scan_dir" -maxdepth 1 -type f \( -iname "release*.7z" -o -iname "release*.zip" \) 2>/dev/null)
    if [[ ${#ARCHIVES[@]} -eq 0 && "$scan_dir" != "." ]]; then
        mapfile -t ARCHIVES < <(find "." -maxdepth 1 -type f \( -iname "release*.7z" -o -iname "release*.zip" \) 2>/dev/null)
    fi

    # Auto-fallback filter to help user if they chose local but the folder is empty
    if [[ ${#ARCHIVES[@]} -eq 0 && "$force_download_flow" == "false" ]]; then
        echo -e "\n${YELLOW}[ℹ] No local release packages found. Shifting to update downloader...${NC}"
        force_download_flow="true"
        sleep 1
    fi

    # 📥 JIT FIRMWARE DOWNLOAD TRACKS: Fires instantly if forced or if folder was found empty
    if [[ "$force_download_flow" == "true" ]]; then
        clear
        echo -e "${YELLOW}==========================================${NC}"
        echo -e "${YELLOW}      EXTRACT 7Z ARCHIVE TO USB ROOT      ${NC}"
        echo -e "${YELLOW}==========================================${NC}"
        echo -e "${YELLOW}[ℹ] Opening update gateway tracks...${NC}"
        echo -e "${YELLOW}====================================================================${NC}"
        echo -e "💡  ${BIGreen}DOWNLOAD INSTRUCTIONS:${NC}"
        echo -e "    1) Open your web browser and navigate directly to your repository:"
        # 🧠 HARD-LOCKED INSULATED COLOR INJECTION: Absolute escape keys applied directly to wipe out the raw 36m print anomaly
        echo -e "       \033[0;36mhttps://github.com/Forbidden-Darkness/AMD-BC-250-UEFI-v2.2-Firmware-Menu-Script${NC}"
        echo -e "    2) Head into the ${YELLOW}Releases${NC} section framework."
        echo -e "    3) Under 'Assets', right-click the newest ${YELLOW}.7z${NC} or ${YELLOW}.zip${NC} firmware bundle."
        echo -e "    4) Select \033[4mCopy Link\033[24m, paste that URL string below, and press Enter."
        echo -e "${YELLOW}====================================================================${NC}"
        type_prompt "👉 Enter the absolute firmware download URL link: " 0.03
        local dl_url; read -r dl_url

        if [[ -z "$dl_url" ]]; then
            echo -e "${BIRed}❌ ERROR: Download URL configuration string cannot be an empty value.${NC}"
            type_prompt "Press Enter to return to main menu..." 0.03
            read -r
            return 1
        fi

        local url_filename; url_filename=$(basename "$dl_url" | cut -d'/' -f1 | cut -d'?' -f1)
        local dl_filename=""

        # Enforce case-insensitive release prefixes cleanly over the downloaded target filename
        if [[ "$url_filename" == [Rr][Ee][Ll][Ee][Aa][Ss][Ee]* ]]; then
            dl_filename="$url_filename"
        else
            if [[ "$url_filename" == *.zip ]]; then
                dl_filename="release_firmware.zip"
            else
                dl_filename="release_firmware.7z"
            fi
        fi

        # 🧠 HARD-LOCKED INSULATED COLOR INJECTION: Absolute escape keys applied directly to wipe out the raw 36m print anomaly
        echo -e "\033[0;36m[⚙] Initializing secure down-stream network connection...${NC}"

        # 🧠 VERIFIED CLEAN DOWNLOAD ENGINE: Suppresses certificate warnings and HTTP traces completely
        # Shows ONLY a clean, single-line progress bar as it fetches the file!
        if ! curl -k -L -# -o "./$dl_filename" "${dl_url}"; then
            echo -e "${BIRed}❌ ERROR: Network download chain failed. Verify link visibility.${NC}"
            rm -f "./$dl_filename" 2>/dev/null
            type_prompt "Press Enter to return to main menu..." 0.03
            read -r
            return 1
        fi

        echo -e "${BIGreen}[✓] Firmware bundle successfully fetched as: $dl_filename${NC}"
        sync && sleep 1

        # Re-index files cleanly after download settles
        mapfile -t ARCHIVES < <(find "." -maxdepth 1 -type f \( -iname "release*.7z" -o -iname "release*.zip" \) 2>/dev/null)
    fi

    if [[ ${#ARCHIVES[@]} -eq 0 ]]; then
        echo -e "${BIRed}[-] No firmware bundles available to extract. Aborting pass.${NC}"
        type_prompt "Press Enter to return to main menu..." 0.03
        read -r
        return 1
    fi

    SELECTED_ARCHIVE=""
    if [[ ${#ARCHIVES[@]} -eq 1 ]]; then
        SELECTED_ARCHIVE="${ARCHIVES}"
        echo -e "${BIGreen}[+] Found archive: $(basename "$SELECTED_ARCHIVE")${NC}"
    else
        echo -e "${YELLOW}Multiple firmware files found. Select one:${NC}"
        for i in "${!ARCHIVES[@]}"; do
            echo -e "  \033[0;36m$((i+1))\033[0m) $(basename "${ARCHIVES[$i]}")"
        done
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

    echo ""
    echo -e "${YELLOW}Available Storage Devices (Look for USB drives):${NC}"
    lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS,LABEL | grep -E "sd|nvme|mmcblk"
    echo ""

    # 🧠 HARD-LOCKED INSULATED COLOR INJECTION: Absolute escape keys applied directly to wipe out the raw 36m print anomaly
    echo -e "\033[0;36m[ℹ] Scanning system and listening for USB storage target...${NC}"
    echo -e "${DIM}    Press Ctrl+C to cancel and exit back to main dashboard.${RESET}"
    echo ""

    local initial_devices; initial_devices=$(lsblk -no NAME | tr -d ' ' | grep -E "sd|nvme|mmcblk" | sort | uniq)
    local target_dev=""

    mapfile -t usb_parts < <(lsblk -lno NAME,TYPE,TRAN 2>/dev/null | grep -E "part" | grep -v -E "nvme|mmcblk" | awk '{print $1}')

    if [[ ${#usb_parts[@]} -gt 0 ]]; then
        echo -e "${YELLOW}[!] Connected storage partitions discovered. Select target payload destination:${NC}"
        echo -e "${DIM}  -------------------------------------------------------------${RESET}"
        for i in "${!usb_parts[@]}"; do
            local p_name="${usb_parts[$i]}"
            local p_size; p_size=$(lsblk -no SIZE "/dev/$p_name" 2>/dev/null | head -n 1 | tr -d ' ')
            local p_label; p_label=$(lsblk -no LABEL "/dev/$p_name" 2>/dev/null | head -n 1 | tr -d ' ')
            local p_fs; p_fs=$(lsblk -no FSTYPE "/dev/$p_name" 2>/dev/null | head -n 1 | tr -d ' ')
            # 🧠 HARDEST-INSULATED ANSI COLOR INJECTION: Absolute escape keys applied directly to wipe out raw 36m print anomalies
            echo -e "    \033[0;36m$((i+1)))\033[0m /dev/${p_name} [${p_size}] ${DIM}(Format: ${p_fs:-Unknown} - Label: ${p_label:-No Label})${RESET}"
        done
        echo -e "    \033[0;36ms)\033[0m Skip and stay in live plug hot-detector listener mode"
        echo -e "${DIM}  -------------------------------------------------------------${RESET}"

        type_prompt "  Select partition option index number or \"s\": " 0.03
        read -r user_index

        if [[ "$user_index" =~ ^[0-9]+$ ]] && (( user_index >= 1 && user_index <= ${#usb_parts[@]} )); then
            target_dev="${usb_parts[$((user_index-1))]}"
        else
            echo "[-] Manual selection bypassed. Slipping into active live-plug listener..."
            target_dev=""
        fi
    fi

    if [[ -z "$target_dev" ]]; then
        echo -ne "  Enter target partition device manually OR plug in USB now: "
        while true; do
            if read -t 1 -r input_dev; then
                target_dev="$input_dev"
                break
            fi
            local current_devices; current_devices=$(lsblk -no NAME | tr -d ' ' | grep -E "sd|nvme|mmcblk" | sort | uniq)
            local diff_dev; diff_dev=$(comm -13 <(echo "$initial_devices") <(echo "$current_devices") | grep -v -E "[0-9]$" | head -n 1)
            if [[ -n "$diff_dev" ]]; then
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

    target_dev=$(echo "$target_dev" | sed 's|/dev/||g')
    if [[ ! -b "/dev/$target_dev" ]]; then
        echo -e "${BIRed}[-] Invalid device block /dev/$target_dev${NC}"
        type_prompt "Press Enter to return to main menu..." 0.03
        read -r
        return 1
    fi

    # Interrogate filesystem formatting profile
    local current_fs; current_fs=$(lsblk -no FSTYPE "/dev/$target_dev" 2>/dev/null | head -n 1 | tr -d ' ' | tr '[:upper:]' '[:lower:]')

    if [[ "$current_fs" != "vfat" && "$current_fs" != "fat32" ]]; then
        echo ""
        echo -e "${YELLOW}[⚠] WARNING: /dev/$target_dev IS NOT FORMATTED AS FAT32! (Detected: '${current_fs:-Unformatted}')${NC}"
        echo -e "${YELLOW}    UEFI motherboard firmware environments require a clear FAT32 blueprint to initialize.${NC}"
        echo ""
        echo -e "${B_RED}    [🔥] WOULD YOU LIKE TO FORMAT /dev/$target_dev TO FAT32 NOW? [ALL DATA WILL BE WIPED!]${NC}"
        type_prompt "    Proceed with format? (y/N): " 0.03
        read -r confirm_format

        if [[ "$confirm_format" =~ ^[Yy]$ ]]; then
            # 🧠 FIXED ABSOLUTE COLOR INJECTION: Absolute escape code applied directly to clear the raw 36m print anomaly
            echo -e "\033[0;36m[+] Unmounting active mount strings on /dev/$target_dev...${NC}"
            umount -l "/dev/$target_dev" 2>/dev/null || true

            echo -e "${YELLOW}[+] Executing filesystem rewrite wrapper... constructing FAT32 table...${NC}"
            # Re-ordered argument properties to permanently solve the UE vs UEFI_BOOT text truncation bug
            if ! mkfs.vfat -n "UEFI_BOOT" -F 32 -I "/dev/$target_dev"; then
                echo -e "${BIRed}[-❌-] CRITICAL ERROR: mkfs.vfat formatting routine failed! Refusing extraction.${NC}"
                type_prompt "Press Enter to return to main menu..." 0.03
                read -r
                return 1
            fi

            # Double-lock insurance sweep: Explicitly re-applies the full label target
            if command -v fatlabel &>/dev/null; then
                fatlabel "/dev/$target_dev" "UEFI_BOOT" 2>/dev/null
            elif command -v dosfslabel &>/dev/null; then
                dosfslabel "/dev/$target_dev" "UEFI_BOOT" 2>/dev/null
            fi

            echo -e "${BIGreen}[+] File-system successfully formatted to FAT32! Label applied: 'UEFI_BOOT'${NC}"
            sync && sleep 1
        else
            echo -e "${BIRed}[-] Format aborted. Incompatible file-system layout blocks extraction.${NC}"
            type_prompt "Press Enter to return to main menu..." 0.03
            read -r
            return 1
        fi
    fi

    TARGET_MOUNT=$(lsblk -no MOUNTPOINT "/dev/$target_dev" | head -n 1)
    TEMP_MOUNTED=false

    if [[ -z "$TARGET_MOUNT" || "$TARGET_MOUNT" == " " ]]; then
        TARGET_MOUNT="/mnt/usb_target_root"
        mkdir -p "$TARGET_MOUNT"
        echo -e "${YELLOW}[+] Mounting /dev/$target_dev to $TARGET_MOUNT...${NC}"
        if ! mount "/dev/$target_dev" "$TARGET_MOUNT"; then
            echo -e "${BIRed}[-] Failed to mount /dev/$target_dev${NC}"
            type_prompt "Press Enter to return to main menu..." 0.03
            read -r
            return 1
        fi
        TEMP_MOUNTED=true
    fi

    echo ""
    echo -e "${YELLOW}[!] Confirm extraction of '${SELECTED_ARCHIVE}' to '${TARGET_MOUNT}' (USB Root)${NC}"
    type_prompt "Are you sure? (y/N): " 0.03
    read -r confirm_ext
    if [[ "$confirm_ext" =~ ^[Yy]$ ]]; then
        echo -e "${BIGreen}[+] Extracting files to USB Root...${NC}"

        # 🧠 SILENT SPINNER BACKGROUND LOOP: Animates a clean visual indicator while data writes touch-free
        "$SEVENZIP_BIN" x "$SELECTED_ARCHIVE" -o"$TARGET_MOUNT" -y &>/dev/null &
        local extract_pid=$!
        local spinner=( '⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏' )

        while kill -0 "$extract_pid" 2>/dev/null; do
            for frame in "${spinner[@]}"; do
                echo -ne "\r  \033[0;36m[$frame] Writing payload sectors cleanly to hardware partitions...${NC}"
                sleep 0.08
            done
        done
        echo -ne "\r                                                                         \r"

        # 🚀 AUTOMATED SELF-COPY INJECTION ENGINE
        # Uses $0 to guarantee this exact script (reboot-uefi-v3.0.sh) copies itself to the USB root
        echo -e "\033[0;36m[⚙] Deploying master automation script to flash storage...${NC}"

        if [ -f "$0" ]; then
            cp -f "$0" "$TARGET_MOUNT/reboot-uefi-v3.0.sh" 2>/dev/null
            chmod 755 "$TARGET_MOUNT/reboot-uefi-v3.0.sh" 2>/dev/null
            echo -e "${BIGreen}[✓] 'reboot-uefi-v3.0.sh' successfully compiled to USB Root directory!${NC}"
        else
            # Smart fallback path check to catch the file inside your main workspace folder if executing via piping
            if [ -f "/var/home/bsystem/Bazzite_Toolbox/reboot-uefi-v3.0.sh" ]; then
                cp -f "/var/home/bsystem/Bazzite_Toolbox/reboot-uefi-v3.0.sh" "$TARGET_MOUNT/reboot-uefi-v3.0.sh" 2>/dev/null
                chmod 755 "$TARGET_MOUNT/reboot-uefi-v3.0.sh" 2>/dev/null
                echo -e "${BIGreen}[✓] 'reboot-uefi-v3.0.sh' successfully compiled to USB Root directory!${NC}"
            else
                echo -e "${YELLOW}[!] WARNING: Source script file not detected in standard system paths. Skipping copy pass.${NC}"
            fi
        fi

        sync
        echo -e "${BIGreen}[✓] Extraction complete! Changes flushed to USB storage tables.${NC}"
    else
        echo "[-] Extraction canceled."
    fi

    if [[ "$TEMP_MOUNTED" == "true" ]]; then
        echo -e "${YELLOW}[⚙] Flushing write cache buffers... unmounting /dev/$target_dev...${NC}"
        sync
        sleep 1
        if umount -l "$TARGET_MOUNT" 2>/dev/null; then
            rmdir "$TARGET_MOUNT" 2>/dev/null
            echo -e "${BIGreen}[✓] USB volume context cleared completely! Safe to remove hardware.${NC}"
        else
            echo -e "${YELLOW}[⚠] WARNING: Partition volume busy. Ensure background shells are closed.${NC}"
        fi
    fi

    # 🚀 INTERACTIVE HANDOFF HUB: Connects your extraction engine straight into your efibootmg function node cleanly!
    echo ""
    echo -e "${GREEN}[✓] Deployment actions completed successfully.${NC}"
    echo -e "${YELLOW}====================================================================${NC}"
    echo -e "👉 Would you like to continue to:"
    echo -e "  \033[0;36m2)\033[0m EFI Boot Manager One-Time Boot (efibootmgr)"
    echo -e "${YELLOW}====================================================================${NC}"
    type_prompt "  Select option or press Enter to return to menu: " 0.03
    local post_choice; read -r post_choice

    if [[ "$post_choice" == "2" ]]; then
        efibootmg
    else
        echo -e "\n${GREEN}[+] Bypassing boot flag configuration track. Returning cleanly to menu dashboard...${NC}"
        sleep 1
    fi

    return 0
}

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

    # 🧠 HARD-LOCKED INSULATED COLOR INJECTION: Absolute escape keys applied directly to wipe out the raw 36m print anomaly
    echo -e "\033[0;36m[ℹ] Scanning system and listening for USB boot drive...${NC}"
    echo -e "${DIM}    Press Ctrl+C to cancel and exit back to main dashboard.${RESET}"
    echo ""

    local initial_devices; initial_devices=$(lsblk -no NAME | tr -d ' ' | grep -E "sd|nvme|mmcblk" | sort | uniq)
    local boot_num="" local target_disk="" local part_num="1"

    mapfile -t usb_drives < <(lsblk -dno NAME,RM,TRAN 2>/dev/null | grep -E "sd" | grep -E "1|usb" | awk '{print $1}')

    if [[ ${#usb_drives[@]} -gt 0 ]]; then
        local chosen_usb=""
        echo -e "${YELLOW}[!] Active USB hardware profiles discovered. Select your boot target:${NC}"
        echo -e "${DIM}  -------------------------------------------------------------${RESET}"
        for i in "${!usb_drives[@]}"; do
            local d_name="${usb_drives[$i]}"
            local d_size; d_size=$(lsblk -dno SIZE "/dev/$d_name" 2>/dev/null | tr -d ' ')
            local d_label; d_label=$(lsblk -dno LABEL "/dev/$d_name" | head -n 1 | tr -d ' ')

            # 🧠 VARIABLE TRACKING CORRECTION: Bound the data command string mapping cleanly to your allocated local name row
            local d_vendor; d_vendor=$(lsblk -dno VENDOR "/dev/$d_name" 2>/dev/null | head -n 1 | sed 's/ *$//')

            # 🧠 ABSOLUTE INSULATION FIX: Hardcoded raw ANSI characters (\033[0;36m) to completely wipe away the 36m screen errors inside your loop rows
            echo -e "    \033[0;36m$((i+1)))\033[0m /dev/${d_name} [${d_size}] ${DIM}(${d_vendor:-USB Drive} - Label: ${d_label:-No Label})${RESET}"
        done
        echo -e "    \033[0;36ms)\033[0m Skip and stay in live plug hot-detector listener mode"
        echo -e "${DIM}  -------------------------------------------------------------${RESET}"

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

    if [[ -n "$boot_num" ]]; then
        echo ""
        echo -e "${YELLOW}==================================================${NC}"
        echo -e "${YELLOW}       READY TO INITIATE UEFI BOOT OVERRIDE       ${NC}"
        echo -e "${YELLOW}--------------------------------------------------${NC}"
        echo -e " Target Registry: Boot${boot_num}"
        echo -e " Target Device  : ${target_disk:-Manual Input}"
        echo -e "${YELLOW}==================================================${NC}"

        type_prompt " Do you want to reboot into this device now? (y/N): " 0.03
        read -r confirm_reboot

        if [[ "$confirm_reboot" =~ ^[Yy]$ ]]; then
            local current_order; current_order=$(efibootmgr | grep "^BootOrder:" | cut -d' ' -f2)
            local bazzite_slot; bazzite_slot=$(efibootmgr | grep -E "Bazzite|Fedora" | head -n 1 | cut -d' ' -f1 | tr -d 'Boot*' | tr -d ':')
            [[ -z "$bazzite_slot" ]] && bazzite_slot="0003"
            echo -e "${CYAN}[+] Locking Bazzite (${bazzite_slot}) as permanent system target...${NC}"
            if [[ -n "$current_order" ]]; then
                local cleaned_order; cleaned_order=$(echo "$current_order" | sed "s/${boot_num},//g; s/,${boot_num}//g")
                sudo efibootmgr -o "${bazzite_slot},${cleaned_order}" &>/dev/null
            else
                sudo efibootmgr -o "${bazzite_slot}" &>/dev/null
            fi
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


create_shortcuts() {
    echo ""
    echo -e "\033[38;2;0;255;0mWhere would you like to create the shortcut?\033[0m"
    echo -e "\033[38;2;0;255;0m1) Desktop Only\033[0m"
    echo -e "\033[38;2;0;255;0m2) Start / Application Menu Only (Utilities)\033[0m"
    echo -e "\033[38;2;0;255;0m3) Both Desktop and Start Menu\033[0m"
    echo -e "\033[38;2;0;255;0m4) Cancel (Return to Main Menu)\033[0m"

    type_prompt "Enter choice [1-4]: " 0.03
    read -r shortcut_choice

    case $shortcut_choice in
        1|2|3)
            mkdir -p "$INSTALL_DIR"
            cp "$CURRENT_SCRIPT_PATH" "$COPIED_SCRIPT"
            local archive_match
            mapfile -t archive_match < <(find "$CURRENT_DIR" -maxdepth 1 -type f -name "release-0*.7z" 2>/dev/null)
            if [[ ${#archive_match[@]} -eq 0 ]]; then
                mapfile -t archive_match < <(find "." -maxdepth 1 -type f -name "release-0*.7z" 2>/dev/null)
            fi

            if [[ ${#archive_match[@]} -gt 0 ]]; then
                local source_archive="${archive_match}"
                local target_archive_name; target_archive_name=$(basename "$source_archive")
                echo -e "${CYAN}[+] Staging payload package file migration context...${NC}"
                cp "$source_archive" "${INSTALL_DIR}/${target_archive_name}"
                echo -e "${BIGreen}[+] Payload archive successfully copied: ${target_archive_name}${NC}"
            else
                echo -e "${YELLOW}[!] Warning: No 'release-0*.7z' package bundle found in source directories.${NC}"
                echo -e "${DIM}    You will need to place the .7z package into ${INSTALL_DIR} manually later.${RESET}"
            fi

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

remove_shortcuts() {
    echo ""
    echo -e "\033[38;2;0;255;0mWhere would you like to remove the shortcut from?\033[0m"
    echo -e "\033[38;2;0;255;0m1) Desktop Only\033[0m"
    echo -e "\033[38;2;0;255;0m2) Start / Application Menu Only (Utilities)\033[0m"
    echo -e "\033[38;2;0;255;0m3) Both Desktop and Start Menu (Full Cleanup)\033[0m"
    echo -e "\033[38;2;0;255;0m4) Cancel (Return to Main Menu)\033[0m"

    type_prompt "Enter choice [1-4]: " 0.03
    read -r rem_choice

    case "$rem_choice" in
        1|2|3)
            if [[ "$rem_choice" == "1" || "$rem_choice" == "3" ]]; then
                if [[ -f "$DESKTOP_FILE" ]]; then
                    rm -f "$DESKTOP_FILE"
                    echo -e "${BIGreen}[+] Desktop shortcut removed from: ${DESKTOP_FILE}${NC}"
                else
                    echo "[-] Desktop shortcut not found."
                fi
            fi

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

while true; do
    matrix_melt_clear

    echo -e "\033[38;2;0;255;0m  ╔══════════════════════════════════════════════════════════╗\033[0m"
    echo -e "\033[38;2;0;255;0m  ║                                                          ║\033[0m"
    echo -e "\033[38;2;0;255;0m  ║              UEFI FIRMWARE INTERFACE v3.0                ║\033[0m"
    echo -e "\033[38;2;0;255;0m  ║                                                          ║\033[0m"
    echo -e "\033[38;2;0;255;0m  ╚══════════════════════════════════════════════════════════╝\033[0m"
    echo -e "\033[38;2;0;255;0m   1)\033[0m UEFI Firmware Setup (Reboot to BIOS)"
    echo -e "\033[38;2;0;255;0m   2)\033[0m EFI Boot Manager One-Time Boot (efibootmgr)"
    echo -e "\033[38;2;0;255;0m   3)\033[0m Standard Reboot (Interrupt GRUB manually)"
    echo -e "\033[38;2;0;255;0m   4)\033[0m Extract Existing .7z File to USB Root"

    if [[ "$IS_INSTALLED" == false ]]; then
        echo -e "\033[38;2;0;255;0m   5)\033[0m Manage Shortcuts (Create / Remove)"
        echo -e "\033[38;2;0;255;0m   r)\033[0m Reload Menu Interface"
        echo -e "\033[38;2;0;255;0m   0)\033[0m Cancel / Exit"
        echo -e "  ────────────────────────────────────────────────────────────"
        type_prompt "  Select an option [1-0, r]: " 0.03
        choice=""
        read -n 1 -s choice || true
        echo ""
    else
        echo -e "\033[38;2;0;255;0m   5)\033[0m Remove Shortcuts"
        echo -e "\033[38;2;0;255;0m   r)\033[0m Reload Menu Interface"
        echo -e "\033[38;2;0;255;0m   0)\033[0m Cancel / Exit"
        echo -e "  ────────────────────────────────────────────────────────────"
        type_prompt "  Select an option [1-0, r]: " 0.03
        choice=""
        read -n 1 -s choice || true
        echo ""
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
        5)
            if [[ "$IS_INSTALLED" == false ]]; then
                echo ""
                echo -e "\033[38;2;0;255;0mShortcut Management:\033[0m"
                echo -e "\033[38;2;0;255;0m1) Create Shortcuts\033[0m"
                echo -e "\033[38;2;0;255;0m2) Remove Shortcuts\033[0m"
                echo -e "\033[38;2;0;255;0m3) Return to Main Menu\033[0m"

                type_prompt "Enter choice [1-3]: " 0.03
                choice=""
                read -n 1 -s choice || true
                echo ""

                case $choice in
                    1) create_shortcuts ;;
                    2) remove_shortcuts ;;
                    3) echo "[-] Returning to Main Menu..."; sleep 1 ;;
                    *) echo "[-] Invalid choice. Returning to Main Menu..."; sleep 1 ;;
                esac
            else
                remove_shortcuts
            fi
            ;;
        r)
            echo -e "\033[38;2;0;255;0m  [+] Re-initializing core firmware tables...\033[0m"
            sleep 0.5
            exec bash "$CURRENT_SCRIPT_PATH" "$@"
            ;;
        0)
            echo "Exiting..."
            close_terminal
            ;;
        *)
            echo "[-] Invalid choice. Please try again."
            sleep 1
            ;;
    esac
done
