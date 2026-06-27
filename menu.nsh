@echo -off
cls

# Check if an argument was provided. If empty, show the menu.
if "%1" == "" then
  goto show_menu
endif

# Route the user choice based on the first parameter (%1)
if "%1" == "01" then
  goto BORIGINAL
endif
if "%1" == "02" then
  goto BORANGE
endif
if "%1" == "03" then
  goto BPRIDE
endif
if "%1" == "04" then
  goto CACHY
endif
if "%1" == "05" then
  goto SUGARY
endif
if "%1" == "06" then
  goto SORIGINAL
endif
if "%1" == "07" then
  goto AMD
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
echo " 01. Bazzite Original Logo            "
echo " 02. Bazzite Orange Logo            "
echo " 03. Bazzite Pride Logo            "
echo " 04. CachyOS Logo            "
echo " 05. Steam Sugary Logo            "
echo " 06. Steam Original Logo            "
echo " 07. AMD Logo            "
echo " 0f. Firmware Backup (Always backup your Firmware First!)            "
echo " 0e. Exit to Bios            "
echo " 0r. Reboot            "
echo "=================================================================================================="
echo " Usage: menu [option]             "
echo "=================================================================================================="
echo "Type 'menu 01' for Bazzite Original Logo, 'Type menu 02' for Bazzite Orange Logo, etc."
goto end_menu

:BORIGINAL
cls
echo " ************************************************"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **     Welcome to Bazzite Original 600x600    **"
echo " ************************************************"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\bazzite_original-600.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\bazzite_original-600.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
goto drive_error

:BORANGE
cls
echo " ************************************************"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **     Welcome to Bazzite Orange 600x600      **"
echo " ************************************************"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\bazzite_organge-600.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\bazzite_organge-600.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
goto drive_error

:BPRIDE
cls
echo " ************************************************"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **     Welcome to Bazzite Pride 600x600       **"
echo " ************************************************"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\bazzite_pride-600.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\bazzite_pride-600.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
goto drive_error

:CACHY
cls
echo " ************************************************"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **     Welcome to CachyOS 600x600             **"
echo " ************************************************"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\cachyos-600.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\cachyos-600.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
goto drive_error

:SUGARY
cls
echo " ************************************************"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **     Welcome to Steam Sugary 600x600        **"
echo " ************************************************"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\steam_sugary-600.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\steam_sugary-600.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
goto drive_error

:SORIGINAL
cls
echo " ************************************************"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **     Welcome to Steam Original 600x600      **"
echo " ************************************************"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\bc250-Steam.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\bc250-Steam.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
goto drive_error

:AMD
cls
echo " ************************************************"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **     Welcome to AMD Logo 600x600            **"
echo " ************************************************"
pause
if exist fs0:\AfuEfix64.efi then
  fs0:\AfuEfix64.efi fs0:\Firmware\bc250-amd.rom /P /N /B /K /RLC:E
  stall 5000000
  goto post_flash
endif
if exist fs1:\AfuEfix64.efi then
  fs1:\AfuEfix64.efi fs1:\Firmware\bc250-amd.rom /P /N /B /K /RLC:E
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
