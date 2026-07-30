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
  goto MeiMeiDXE-Steam
endif
if "%1" == "04" then
  goto MeiMeiDXE-CachyOS
endif
if "%1" == "05" then
  goto MeiMeiDXE-SteamOS
endif
if "%1" == "06" then
  goto MeiMeiDXE-AMD
endif
if "%1" == "0f" then
  goto FIRMWARE
endif
if "%1" == "0e" then
  goto EXIT
endif
if "%1" == "0r" then
  goto REBOOT
endif

echo "Invalid selection: %1"
echo "Please choose a valid two-digit menu option."
goto end_menu

:show_menu
echo "=================================================================================================="
echo "  AMD BC-250 UEFI v2.2 Firmware Menu Script        "
echo "=================================================================================================="
echo " Remember to configure GFX Configuration after each successful BIOS Flash.            "
echo " Modded firmware with the chipset menu exposed. Based on BC250 P3.00 ROM.        "
echo "=================================================================================================="
echo " 01. MeiMeiDXE - No Logo with Permanent 8 Cores unlocked           "
echo " 02. MeiMeiDXE - Bazzite Logo with Permanent 8 Cores unlocked            "
echo " 03. MeiMeiDXE - Steam Logo with Permanent 8 Cores unlocked            "
echo " 04. MeiMeiDXE - CachyOS Logo with Permanent 8 Cores unlocked            "
echo " 05. MeiMeiDXE - Steam Name Logo with Permanent 8 Cores unlocked            "
echo " 06. MeiMeiDXE - AMD Logo with Permanent 8 Cores unlocked            "
echo " 0f. Firmware Backup (Always backup your Firmware First!)            "
echo " 0e. Exit to Bios            "
echo " 0r. Reboot            "
echo "=================================================================================================="
echo " Usage: menu [option]             "
echo "=================================================================================================="
echo "Type 'menu 01' for No Logo, 'Type menu 02' for Bazzite Logo, etc."
goto end_menu

:MeiMeiDXE
cls
echo " ***********************************************************"
echo " ** 	(WARNING) Flash Firmware at your own RISK! 	**"
echo " **     Welcome to MeiMeiDXE-No Logo 8 Cores unlocked  	**"
echo " ***********************************************************"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-Bazzite
cls
echo " *****************************************************************"
echo " **         (WARNING) Flash Firmware at your own RISK!	      **"
echo " **     Welcome to MeiMeiDXE-BazziteOS Logo 8 Cores unlocked    **"
echo " *****************************************************************"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-BazziteOS /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-BazziteOS /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-Steam
cls
echo " *****************************************************************"
echo " **        (WARNING) Flash Firmware at your own RISK!	      **"
echo " **     Welcome to MeiMeiDXE-SteamOS Logo 8 Cores unlocked      **"
echo " *****************************************************************"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-SteamOS /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-SteamOS /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-CachyOS
cls
echo " *****************************************************************"
echo " **        (WARNING) Flash Firmware at your own RISK!	      **"
echo " **     Welcome to MeiMeiDXE-CachyOS Logo 8 Cores unlocked      **"
echo " *****************************************************************"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-CachyOS /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-CachyOS /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-SteamOS
cls
echo " **********************************************************************"
echo " **           (WARNING) Flash Firmware at your own RISK!	           **"
echo " **     Welcome to MeiMeiDXE-SteamOS Name Logo 8 Cores unlocked      **"
echo " **********************************************************************"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-SteamOS_Name /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-SteamOS_Name /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
goto drive_error

:MeiMeiDXE-AMD
cls
echo " **********************************************************************"
echo " **         (WARNING) Flash Firmware at your own RISK!	           **"
echo " **     	Welcome to MeiMeiDXE-AMD Logo 8 Cores unlocked   	   **"
echo " **********************************************************************"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\BC250_3.00_MeiMeiDXE-AMD /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\BC250_3.00_MeiMeiDXE-AMD /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
goto drive_error

:FIRMWARE
cls
echo "Preparing original firmware backup sequence..."
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

:post_flash
echo "Firmware update finished. Press Enter to return to main menu."
pause -q
cls
goto show_menu

:post_backup
echo "Firmware Backup Completed successfully. Press Enter."
pause -q
cls
goto show_menu

:drive_error
echo "ERROR: AfuEfix64.efi was not detected on fs0: or fs1:."
echo "Check USB file placement."
pause
cls
goto show_menu

:REBOOT
reset

:EXIT
exit

:end_menu
