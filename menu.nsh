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

echo "Invalid selection: %1"
echo "Please choose a valid two-digit menu option."
echo "Press Enter to return to menu."
pause -q
goto show_menu

:show_menu
cls
echo "===================================================================================================="
echo "  AMD BC-250 UEFI v2.2 Firmware Menu Script        "
echo "===================================================================================================="
echo " Remember to configure GFX Configuration after each successful BIOS Flash.            "
echo " Modded MeiMeiDXE v2 Firmware with the chipset menu exposed and Permanent 8 Cores unlocked with safety On/Off Toggle. Based on BC250 P3.00 ROM.      "
echo "===================================================================================================="
echo " 01. MeiMeiDXE v2 - No Logo, Permanent 8 Cores unlocked with safety On/Off Toggle        "
echo " 02. MeiMeiDXE v2 - Bazzite Logo, Permanent 8 Cores unlocked with safety On/Off Toggle         "
echo " 03. MeiMeiDXE v2 - Steam Logo, Permanent 8 Cores unlocked with safety On/Off Toggle        "
echo " 04. MeiMeiDXE v2 - Steam XL Logo, Permanent 8 Cores unlocked with safety On/Off Toggle        "
echo " 05. MeiMeiDXE v2 - CachyOS Logo, Permanent 8 Cores unlocked with safety On/Off Toggle         "
echo " 06. MeiMeiDXE v2 - Steam Name Logo, Permanent 8 Cores unlocked with safety On/Off Toggle         "
echo " 07. MeiMeiDXE v2 - AMD Logo, Permanent 8 Cores unlocked with safety On/Off Toggle         "
echo " 08. MeiMeiDXE v2 - AMD Pure Whit Logo, Permanent 8 Cores unlocked with safety On/Off Toggle      "
echo " 09. MeiMeiDXE v2 - SteamOS BlackOutCapsule, Permanent 8 Cores unlocked with safety On/Off Toggle"
echo " 10. MeiMeiDXE v2 - SteamOS BlackOutCapsule.2, Permanent 8 Cores unlocked with safety On/Off Toggle"
echo " 11. MeiMeiDXE v2 - Steam Name Glass Bubble, Permanent 8 Cores unlocked with safety On/Off Toggle"
echo " 12. MeiMeiDXE v2 - Steam Name Frost Bubble, Permanent 8 Cores unlocked with safety On/Off Toggle"
echo " 13. MeiMeiDXE v2 - Steam Logo + Steam Name, Permanent 8 Cores unlocked with safety On/Off Toggle"
echo " 0f. Firmware Backup (Always backup your Firmware First!)            "
echo " fr. Recover from Firmware Backup (Make sure you backup first before making any changes!)    "
echo " 0e. Exit to Bios            "
echo " 0r. Reboot            "
echo "===================================================================================================="
echo " Usage: menu [option]             "
echo "===================================================================================================="
echo "Type 'menu 01' for No Logo, 'Type menu 02' for Bazzite Logo, etc."
goto end_menu

:MeiMeiDXE
cls
echo -b " +****************************************************************************+"
echo -b " **               (WARNING) Flash Firmware at your own RISK!                 **"
echo -b " **     Welcome to MeiMeiDXE-v2 No Logo 8 Cores unlocked with On/Off Toggle  **"
echo -b " +****************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-T-v2 /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-T-v2 /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-Bazzite
cls
echo -b " +**********************************************************************************+"
echo -b " **                 (WARNING) Flash Firmware at your own RISK!                     **"
echo -b " **   Welcome to MeiMeiDXE-v2 BazziteOS Logo 8 Cores unlocked with On/Off Toggle   **"
echo -b " +**********************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-BazziteOS /P /B /N /K /RLC:E /CLRCFG
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-BazziteOS /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-Steam.M
cls
echo -b " +**********************************************************************************+"
echo -b " **                 (WARNING) Flash Firmware at your own RISK!                     **"
echo -b " **   Welcome to MeiMeiDXE-v2 SteamOS Logo 8 Cores unlocked with On/Off Toggle     **"
echo -b " +**********************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS.M /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS.M /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-Steam.XL
cls
echo -b " +*************************************************************************************+"
echo -b " **                 (WARNING) Flash Firmware at your own RISK!                        **"
echo -b " **  Welcome to MeiMeiDXE-v2 SteamOS X-Large Logo 8 Cores unlocked with On/Off Toggle **"
echo -b " +*************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS.XL /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS.XL /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-CachyOS
cls
echo -b " +**********************************************************************************+"
echo -b " **                  (WARNING) Flash Firmware at your own RISK!                    **"
echo -b " **     Welcome to MeiMeiDXE-v2 CachyOS Logo 8 Cores unlocked with On/Off Toggle   **"
echo -b " +**********************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-CachyOS /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-CachyOS /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-SteamOS
cls
echo -b " +***************************************************************************************+"
echo -b " **                    (WARNING) Flash Firmware at your own RISK!                       **"
echo -b " **    Welcome to MeiMeiDXE-v2 SteamOS Name Logo 8 Cores unlocked with On/Off Toggle    **"
echo -b " +***************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS_Name /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS_Name /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-AMD
cls
echo -b " +***************************************************************************************+"
echo -b " **                  (WARNING) Flash Firmware at your own RISK!                         **"
echo -b " **       Welcome to MeiMeiDXE-v2 AMD Logo 8 Cores unlocked with On/Off Toggle          **"
echo -b " +***************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-AMD /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-AMD /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-AMD.PW
cls
echo -b " +***************************************************************************************+"
echo -b " **                   (WARNING) Flash Firmware at your own RISK!                        **"
echo -b " **   Welcome to MeiMeiDXE-v2 AMD Pure White Logo 8 Cores unlocked with On/Off Toggle   **"
echo -b " +***************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-AMD.PW /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-AMD.PW /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-SteamOS-BlackOut
cls
echo -b " +**********************************************************************************************+"
echo -b " **                   (WARNING) Flash Firmware at your own RISK!                               **"
echo -b " **  Welcome to MeiMeiDXE-v2 SteamOS BlackOutCapsule Logo 8 Cores unlocked with On/Off Toggle  **"
echo -b " +**********************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS-BlackOut /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS-BlackOut /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-SteamOS-BlackOut.2
cls
echo -b " +**********************************************************************************************+"
echo -b " **                    (WARNING) Flash Firmware at your own RISK!                              **"
echo -b " ** Welcome to MeiMeiDXE-v2 SteamOS BlackOutCapsule 2 Logo 8 Cores unlocked with On/Off Toggle **"
echo -b " +**********************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS-BlackOut.2 /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS-BlackOut.2 /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-SteamOS.GB
cls
echo -b " +**********************************************************************************************+"
echo -b " **                     (WARNING) Flash Firmware at your own RISK!                             **"
echo -b " ** Welcome to MeiMeiDXE-v2 SteamOS Name Glass Bubble Logo 8 Cores unlocked with On/Off Toggle **"
echo -b " +**********************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS_Name.GB /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS_Name.GB /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-SteamOS.FST
cls
echo -b " +**********************************************************************************************+"
echo -b " **                 (WARNING) Flash Firmware at your own RISK!                                 **"
echo -b " ** Welcome to MeiMeiDXE-v2 SteamOS Name Frost Bubble Logo 8 Cores unlocked with On/Off Toggle **"
echo -b " +**********************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS_Name.FST /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS_Name.FST /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-SteamOS.LG+N
cls
echo -b " +*****************************************************************************************+"
echo -b " **                  (WARNING) Flash Firmware at your own RISK!                           **"
echo -b " **   Welcome to MeiMeiDXE-v2 SteamOS Logo + Name 8 Cores unlocked with On/Off Toggle     **"
echo -b " +*****************************************************************************************+"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS_LG+N /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-T-v2-SteamOS_LG+N /P /B /N /K /RLC:E /CLRCFG
  stall 5000000
  goto post_flash
endif
goto drive_error

:FIRMWARE
cls
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
cls
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
echo -b " Firmware update Finished. Press Enter to return to main menu."
pause -q
goto show_menu

:post_backup
echo -b " Firmware Backup Completed Successfully. Press Enter."
pause -q
goto show_menu

:post_recovery
echo -b " Firmware Recovery Finished. Press Enter to return to main menu."
pause -q
goto show_menu

:drive_error
echo -b "ERROR: AfuEfix64.efi was not detected on fs0: or fs1:."
echo -b "Check USB file placement."
pause
goto show_menu

:REBOOT
reset

:EXIT
exit

:end_menu
