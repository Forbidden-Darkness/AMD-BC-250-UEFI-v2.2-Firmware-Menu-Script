@echo -off
cls

# Check if an argument was provided. If empty, show the menu.
if "%1" == "" then
  goto show_menu
endif

# Route the user choice based on the first parameter (%1)
if "%1" == "01" then
  goto MeiMeiDXE
endif
if "%1" == "02" then
  goto MeiMeiDXE-Bazzite
endif
if "%1" == "03" then
  goto MeiMeiDXE-Steam.M
endif
if "%1" == "04" then
  goto MeiMeiDXE-Steam.XL
endif
if "%1" == "05" then
  goto MeiMeiDXE-CachyOS
endif
if "%1" == "06" then
  goto MeiMeiDXE-SteamOS
endif
if "%1" == "07" then
  goto MeiMeiDXE-AMD
endif
if "%1" == "08" then
  goto MeiMeiDXE-AMD.PW
endif
if "%1" == "09" then
  goto MeiMeiDXE-SteamOS-BlackOut
endif
if "%1" == "10" then
  goto MeiMeiDXE-SteamOS-BlackOut.2
endif
if "%1" == "11" then
  goto MeiMeiDXE-SteamOS.GB
endif
if "%1" == "12" then
  goto MeiMeiDXE-SteamOS.FST
endif
if "%1" == "13" then
  goto MeiMeiDXE-SteamOS.LG+N
endif
if "%1" == "14" then
  goto BC250
endif
if "%1" == "R1" then
  goto ATARI
endif
if "%1" == "R2" then
  goto WEYLAND
endif
if "%1" == "R3" then
  goto MeiMeiDXE-PUNSH
endif
if "%1" == "0f" then
  goto FIRMWARE
endif
if "%1" == "fr" then
  goto FIRMWARE-RECOVERY
endif
if "%1" == "0e" then
  goto EXIT
endif
if "%1" == "0r" then
  goto REBOOT
endif
if "%1" == "0s" then
  goto SHUTDOWN
endif

echo "Invalid selection: %1"
echo "Please choose a valid two-digit menu option."
echo "Press Enter to return to menu."
pause -q
goto show_menu

:show_menu
cls 0 14
echo " "
echo "===================================================================================================="
echo "                                AMD BC-250 UEFI v2.2 Firmware Menu"
echo "===================================================================================================="
echo "  All profiles deploy: MeiMeiDXE v2.1, Persistent 8-Core Unlocking, and ACPI Toggles"
echo "===================================================================================================="
echo " "
echo " FIRMWARE FLASH CHOICES: "
echo "  [menu 01]  Disable Boot Splash Logo      [menu 08]  AMD Logo (Monochrome White) "
echo "  [menu 02]  Bazzite OS Logo               [menu 09]  SteamOS BlackOutCapsule v1 "
echo "  [menu 03]  Steam Standard Logo           [menu 10]  SteamOS BlackOutCapsule v2 "
echo "  [menu 04]  Steam XL Scaling Logo         [menu 11]  Steam Text (Glass Bubble Effect) "
echo "  [menu 05]  CachyOS Logo                  [menu 12]  Steam Text (Frost Bubble Effect) "
echo "  [menu 06]  Steam Graphic Wordmark        [menu 13]  Steam Standard Logo + Wordmark"
echo "  [menu 07]  AMD Standard Logo             [menu 14]  BC250 Logo (Monochrome White) "
echo " "
echo " UTILITIES & SYSTEM:"
echo "  [menu 0f]  Export Current ROM Backup     [menu fr]  Restore Existing ROM Backup "
echo " "
echo "  [menu bios] Exit to Setup Utility   /   [menu 0r] System Cold Reset   /   [menu 0s] ACPI Shutdown "
echo " "
echo "===================================================================================================="
echo "Syntax: Enter command identifier (e.g., 'menu 01' to flash target image). Note: [ 0 = Numeric Zero ]"
echo "===================================================================================================="
echo " "
goto end_menu


:MeiMeiDXE
cls 7 1
echo -b " +****************************************************************************+"
echo -b " **               (WARNING) Flash Firmware at your own RISK!                 **"
echo -b " **       Welcome to MeiMeiDXE-v2.1 No Logo 8 Cores unlocked / ACPI Fix	  **"
echo -b " +****************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4 /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4 /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-Bazzite
cls 7 1
echo -b " +**********************************************************************************+"
echo -b " **                 (WARNING) Flash Firmware at your own RISK!                     **"
echo -b " **     Welcome to MeiMeiDXE-v2.1 BazziteOS Logo 8 Cores unlocked / ACPI Fix       **"
echo -b " +**********************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-BazziteOS /P /B /N /K /RLC:E /CLRCFG
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-BazziteOS /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-Steam.M
cls 7 1
echo -b " +**********************************************************************************+"
echo -b " **                 (WARNING) Flash Firmware at your own RISK!                     **"
echo -b " **     Welcome to MeiMeiDXE-v2.1 SteamOS Logo 8 Cores unlocked / ACPI Fix         **"
echo -b " +**********************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS.M /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS.M /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-Steam.XL
cls 7 1
echo -b " +*************************************************************************************+"
echo -b " **                 (WARNING) Flash Firmware at your own RISK!                        **"
echo -b " **     Welcome to MeiMeiDXE-v2.1 SteamOS X-Large Logo 8 Cores unlocked / ACPI Fix    **"
echo -b " +*************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS.XL /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS.XL /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-CachyOS
cls 7 1
echo -b " +**********************************************************************************+"
echo -b " **                  (WARNING) Flash Firmware at your own RISK!                    **"
echo -b " **        Welcome to MeiMeiDXE-v2.1 CachyOS Logo 8 Cores unlocked / ACPI Fix      **"
echo -b " +**********************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-CachyOS /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-CachyOS /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-SteamOS
cls 7 1
echo -b " +***************************************************************************************+"
echo -b " **                    (WARNING) Flash Firmware at your own RISK!                       **"
echo -b " **        Welcome to MeiMeiDXE-v2.1 SteamOS Name Logo 8 Cores unlocked / ACPI Fix      **"
echo -b " +***************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS_Name /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS_Name /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-AMD
cls 7 1
echo -b " +***************************************************************************************+"
echo -b " **                  (WARNING) Flash Firmware at your own RISK!                         **"
echo -b " **           Welcome to MeiMeiDXE-v2.1 AMD Logo 8 Cores unlocked / ACPI Fix            **"
echo -b " +***************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-AMD /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-AMD /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-AMD.PW
cls 7 1
echo -b " +***************************************************************************************+"
echo -b " **                   (WARNING) Flash Firmware at your own RISK!                        **"
echo -b " **       Welcome to MeiMeiDXE-v2.1 AMD Pure White Logo 8 Cores unlocked / ACPI Fix     **"
echo -b " +***************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-AMD.PW /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-AMD.PW /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-SteamOS-BlackOut
cls 7 1
echo -b " +**********************************************************************************************+"
echo -b " **                     (WARNING) Flash Firmware at your own RISK!                             **"
echo -b " **        Welcome to MeiMeiDXE-v2.1 SteamOS BlackOutCapsule Logo 8 Cores / ACPI Fix           **"
echo -b " +**********************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS-BlackOut /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS-BlackOut /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-SteamOS-BlackOut.2
cls 7 1
echo -b " +**********************************************************************************************+"
echo -b " **                    (WARNING) Flash Firmware at your own RISK!                              **"
echo -b " **       Welcome to MeiMeiDXE-v2.1 SteamOS BlackOutCapsule 2 Logo 8 Cores / ACPI Fix          **"
echo -b " +**********************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS-BlackOut.2 /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS-BlackOut.2 /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-SteamOS.GB
cls 7 1
echo -b " +**********************************************************************************************+"
echo -b " **                     (WARNING) Flash Firmware at your own RISK!                             **"
echo -b " **       Welcome to MeiMeiDXE-v2.1 SteamOS Name Glass Bubble Logo 8 Cores / ACPI Fix          **"
echo -b " +**********************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS_Name.GB /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS_Name.GB /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-SteamOS.FST
cls 7 1
echo -b " +**********************************************************************************************+"
echo -b " **                 (WARNING) Flash Firmware at your own RISK!                                 **"
echo -b " **    Welcome to MeiMeiDXE-v2.1 SteamOS Name Frost Bubble Logo 8 Cores unlocked / ACPI Fix    **"
echo -b " +**********************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS_Name.FST /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS_Name.FST /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-SteamOS.LG+N
cls 7 1
echo -b " +*****************************************************************************************+"
echo -b " **                  (WARNING) Flash Firmware at your own RISK!                           **"
echo -b " **       Welcome to MeiMeiDXE-v2.1 SteamOS Logo + Name 8 Cores unlocked / ACPI Fix       **"
echo -b " +*****************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS_LG+N /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-SteamOS_LG+N /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:ATARI
cls 7 1
echo -b " +*****************************************************************************************+"
echo -b " **                  (WARNING) Flash Firmware at your own RISK!                           **"
echo -b " **           Welcome to MeiMeiDXE-v2.1 ATARI Logo 8 Cores unlocked / ACPI Fix            **"
echo -b " +*****************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-Atari /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-Atari /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:WEYLAND
cls 7 1
echo -b " +*****************************************************************************************+"
echo -b " **                  (WARNING) Flash Firmware at your own RISK!                           **"
echo -b " **         Welcome to MeiMeiDXE-v2.1 WEYLAND Logo 8 Cores unlocked / ACPI Fix            **"
echo -b " +*****************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-Weyland /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-Weyland /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:BC250
cls 7 1
echo -b " +**********************************************************************************+"
echo -b " **                   (WARNING) Flash Firmware at your own RISK!                   **"
echo -b " **         Welcome to MeiMeiDXE-v2.1 BC250 Logo 8 Cores unlocked / ACPI Fix       **"
echo -b " +**********************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-BC250 /P /B /N /K /RLC:E /CLRCFG
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-BC250 /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-PUNSH
cls 7 1
echo -b " +**********************************************************************************+"
echo -b " **                 (WARNING) Flash Firmware at your own RISK!                     **"
echo -b " **         Welcome to MeiMeiDXE-v2.1 PUNSH Logo 8 Cores unlocked / ACPI Fix       **"
echo -b " +**********************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-PUNSH /P /B /N /K /RLC:E /CLRCFG
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXEv2.1-TA-v4-PUNSH /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:FIRMWARE
cls 7 1
echo "Preparing to backup your current firmware..."
if exist fs0:\AfuEfix64.efi then
  fs0:
  mkdir \Firmware_Backup
  fs0:\AfuEfix64.efi fs0:\Firmware_Backup\bc250-backup.rom /O
  stall 5000000
  goto post_backup
endif
if exist fs1:\AfuEfix64.efi then
  fs1:
  mkdir \Firmware_Backup
  fs1:\AfuEfix64.efi fs1:\Firmware_Backup\bc250-backup.rom /O
  stall 5000000
  goto post_backup
endif
goto drive_error

:FIRMWARE-RECOVERY
cls 7 1
echo "Recovering from last good known firmware backup..."
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware_Backup\bc250-backup.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_recovery
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware_Backup\bc250-backup.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_recovery
endif
goto drive_error

:post_flash
cls 7 4
echo -b " Firmware Update Completed, This system will now reboot (Press Enter) to continue."
pause -q
reset -c

:post_backup
cls 7 4
echo -b " Firmware Backup Completed Successfully. Press Enter."
pause -q
goto show_menu

:post_recovery
cls 7 4
echo -b " Firmware Recovery Finished. Press Enter to return to main menu."
pause -q
goto show_menu

:drive_error
cls 7 4
echo -b "ERROR: AfuEfix64.efi was not detected on fs0: or fs1:."
echo -b "Check USB file placement."
pause
goto show_menu

:REBOOT
reset -c

:SHUTDOWN
reset -s

:EXIT
exit

:end_menu
