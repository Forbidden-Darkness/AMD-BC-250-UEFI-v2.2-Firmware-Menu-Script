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
echo "Please choose a number between 1 and 5."
goto end_menu

:show_menu
echo "=================================================================================================="
echo "  AMD BC-250 UEFI v2.2 Firmware Menu Script        "
echo "=================================================================================================="
echo " Remember to configure GFX Configuration after each successful BIOS Flash.            "
echo " Modded firmware with the chipset menu exposed and modified to allow access to NBIO Common Options.  Based on BC250 P3.00 ROM        "
echo "=================================================================================================="
echo " 01. Bazzite Original Logo            "
echo " 02. Bazzite Orange Logo            "
echo " 03. Bazzite Pride Logo            "
echo " 04. CachyOS Logo            "
echo " 05. Steam Sugary Logo            "
echo " 06. Steam Original Logo            "
echo " 07. AMD Logo            "
echo " 0f. Firmware Backup (Always backup your Firmware Fist)            "
echo " 0e. Exit to Bios            "
echo " 0r. Reboot            "
echo "=================================================================================================="
echo " Usage: menu [option]             "
echo "=================================================================================================="
echo "Type 'menu 1' for Bazzite Original Logo, 'Type menu 2' for Bazzite Orange Logo, etc."
goto end_menu

:BORIGINAL
echo " ************************************************"
echo " **                                            **"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **     Welcome to Bazzite Original 600x600    **"
echo " ************************************************"
pause
fs0:
AfuEfix64.efi /Firmware/bazzite_original-600.rom /P /N /B /K /RLC:E
stall 5000000
fs1:
AfuEfix64.efi /Firmware/bazzite_original-600.rom /P /N /B /K /RLC:E
stall 5000000
echo "Firmware has been successfully updated 'Press Enter to Continue'"
pause -q
cls
goto show_menu

:BORANGE
echo " ************************************************"
echo " **                                            **"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **      Welcome to Bazzite Orange 600x600     **"
echo " ************************************************"
pause
fs0:
AfuEfix64.efi /Firmware/bazzite_organge-600.rom /P /N /B /K /RLC:E
stall 5000000
fs1:
AfuEfix64.efi /Firmware/bazzite_organge-600.rom /P /N /B /K /RLC:E
stall 5000000
echo "Firmware has been successfully updated 'Press Enter to Continue'"
pause -q
cls
goto show_menu

:BPRIDE
echo " ************************************************"
echo " **                                            **"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **      Welcome to Bazzite Pride 600x600      **"
echo " ************************************************"
pause
fs0:
AfuEfix64.efi /Firmware/bazzite_pride-600.rom /P /N /B /K /RLC:E
stall 5000000
fs1:
AfuEfix64.efi /Firmware/bazzite_pride-600.rom /P /N /B /K /RLC:E
stall 5000000
echo "Firmware has been successfully updated 'Press Enter to Continue'"
pause -q
cls
goto show_menu

:CACHY
echo " ************************************************"
echo " **                                            **"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **      Welcome to CachyOS 600x600            **"
echo " ************************************************"
pause
fs0:
AfuEfix64.efi /Firmware/cachyos-600.rom /P /N /B /K /RLC:E
stall 5000000
fs1:
AfuEfix64.efi /Firmware/cachyos-600.rom /P /N /B /K /RLC:E
stall 5000000
echo "Firmware has been successfully updated 'Press Enter to Continue'"
pause -q
cls
goto show_menu

:SUGARY
echo " ************************************************"
echo " **                                            **"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **      Welcome to Steam Sugary 600x600       **"
echo " ************************************************"
pause
fs0:
AfuEfix64.efi /Firmware/steam_sugary-600.rom /P /N /B /K /RLC:E
stall 5000000
fs1:
AfuEfix64.efi /Firmware/steam_sugary-600.rom /P /N /B /K /RLC:E
stall 5000000
echo "Firmware has been successfully updated 'Press Enter to Continue'"
pause -q
cls
goto show_menu

:SORIGINAL
echo " ************************************************"
echo " **                                            **"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **      Welcome to BC-250 Steam 600x600       **"
echo " ************************************************"
pause
fs0:
AfuEfix64.efi /Firmware/bc250-Steam.rom /P /N /B /K /RLC:E
stall 5000000
fs1:
AfuEfix64.efi /Firmware/bc250-Steam.rom /P /N /B /K /RLC:E
stall 5000000
echo "Firmware has been successfully updated 'Press Enter to Continue'"
pause -q
cls
goto show_menu

:AMD
echo " ************************************************"
echo " **                                            **"
echo " ** (WARNING) Flash Firmware at your own RISK! **"
echo " **      Welcome to AMD BC-250 600x600         **"
echo " ************************************************"
pause
fs0:
AfuEfix64.efi /Firmware/bc250-amd.rom /P /N /B /K /RLC:E
stall 5000000
fs1:
AfuEfix64.efi /Firmware/bc250-amd.rom /P /N /B /K /RLC:E
stall 5000000
echo "Firmware has been successfully updated 'Press Enter to Continue'"
pause -q
cls
goto show_menu

:FIRMWARE
echo " *******************************************************************"
echo " **                                                               **"
echo " ** Firmware Backup is about to begin - Press any key to Continue **"
echo " **                                                               **"
echo " *******************************************************************"
echo
echo " ** Backing up to fs0: ** "
pause
fs0:
AfuEfix64.efi /Firmware_Backup/bc250-backup.rom /O
stall 5000000
echo
echo " ** Backing up to fs1: ** "
pause
fs1:
AfuEfix64.efi /Firmware_Backup/bc250-backup.rom /O
stall 5000000
echo "Firmware Backup Completed successfully 'Press Enter to Continue'"
pause -q
cls
goto show_menu

:REBOOT
reset

:EXIT
exit

:end_menu

# AfuEfix64.efi bios.rom /P /N /B /K /RLC:E /REBOOT