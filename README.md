# AMD BC-250 UEFI v2.2 Firmware Menu Script

An advanced configuration and firmware menu script featuring 8 unlocked cores, ACPI fixes, individual on/off toggles, and multiple custom boot logos for the AMD BC-250.

---

> [!IMPORTANT]
> **Instructional Video Included**
> Please refer to the accompanying video demonstration for exact configuration and deployment steps.


### USB Preparation & Execution Instructions

1. Download **`reboot-uefi.sh`** and the latest release archive (`*.7z`) directly to the root directory of your USB flash drive.
2. Open a terminal session in the root directory of your USB drive.
3. Grant execution permissions to the script and run it with superuser privileges:

```bash
curl -LO https://github.com/Forbidden-Darkness/AMD-BC-250-UEFI-v2.2-Firmware-Menu-Script/releases/download/v0.4.0/reboot-uefi.sh && curl -LO https://github.com/Forbidden-Darkness/AMD-BC-250-UEFI-v2.2-Firmware-Menu-Script/releases/download/v0.4.0/release-0.4.1.7z && chmod +x reboot-uefi.sh &&  sudo bash reboot-uefi.sh
```
4. Select **Option 4** from the main menu to extract the release archive (`*.7z`) directly to the root directory of your USB flash drive.
5. Select **Option 2** from the main menu to reboot the system into the Firmware-Menu-Script on the USB flash drive using the one-time NVRAM boot target (`efibootmgr`).

[![Watch the video](assets/[thumbnail.jpg](https://github.com/user-attachments/assets/ca629326-6095-428d-b8d3-64777df2b705))](https://github.com/user-attachments/assets/32d68515-1ba7-4271-ba56-0916500dafa3)

---

### Feature Summary

* **Option 1 (Direct to UEFI/BIOS):** Automatically restarts the system directly into the UEFI/BIOS setup interface via `systemctl reboot --firmware-setup`.
* **Option 2 (Direct to USB Boot Target):** Initiates a reboot targeting a specific bootable USB drive using `efibootmgr` to set a one-time Non-Volatile RAM (NVRAM) boot target (`--bootnext`).
* **Option 3 (Standard System Reboot):** Triggers a standard system reboot, allowing the operator to manually intercept the boot sequence and invoke the GRUB menu or motherboard boot selector.
* **Option 4 (Extract 7z Archive to USB Root):** Interactively scans for `.7z` archives in the execution directory, detects attached storage block devices (`lsblk`), automatically handles temporary mounting, and unpacks the archive directly onto the root filesystem of the target USB partition.
* **Option 5 (Dynamic Shortcut & Lifecycle Management):** Interactively deploys or purges custom FreeDesktop `.desktop` shortcuts within `~/Desktop` and `~/.local/share/applications/` (Utilities). Automatically synchronizes local desktop databases via `update-desktop-database`, configures elevated execution privileges (`sudo`), and automatically cleans up the target installation directory (`~/Reboot-to-UEFI`) upon shortcut removal.
<br>

1. When prompted, select option **2** for EFI Boot Manager One-Time Boot

  ![Option1](https://github.com/user-attachments/assets/35ffa9af-b0ef-4af1-9895-24b96a089afa)

2. When prompted, enter the hex number corresponding to your USB device (e.g., `0002`), Confirm your selection and press **Enter**. Wait a few seconds for the script to execute the boot override.
  
  ![Option3](https://github.com/user-attachments/assets/fd59fe7d-4acd-47e1-bacd-32248d7f27b8)

3. The system will now reboot immediately into the selected UEFI USB target.
---

## 🚀 Quick Command

To quickly reboot your system straight into the UEFI firmware/BIOS setup from Linux, run:

```bash
systemctl reboot --firmware-setup
```

---

## 📸 Menu & BIOS Previews

<details>
<summary><b>Click to expand Menu & BIOS Screenshots</b></summary>

| Menu Preview 1 | Menu Preview 2 | Menu Preview 3 |
| :---: | :---: | :---: |
| ![Menu1](https://github.com/user-attachments/assets/44bfcd28-13f7-461c-84f4-bc2266ef1354) | ![Menu2](https://github.com/user-attachments/assets/2bd19cef-ee10-4cdb-9d17-59f331e51818) | ![Menu3](https://github.com/user-attachments/assets/140e7997-71f5-40bd-b611-3bc3860a55f9) |

| Menu Preview 4 | Menu Preview 5 | BIOS Screen 1 |
| :---: | :---: | :---: |
| ![Menu4](https://github.com/user-attachments/assets/12e0c2d4-366c-4331-9fea-32323c882848) | ![Menu5](https://github.com/user-attachments/assets/2884545e-6e9c-4911-b35a-409a302609ce) | ![Bios1](https://github.com/user-attachments/assets/aeaec79a-361d-41ee-ab04-15961ffd14ba) |

| BIOS Screen 2 | BIOS Screen 3 | BIOS Screen 4 |
| :---: | :---: | :---: |
| ![Bios2](https://github.com/user-attachments/assets/6e78ae77-43c1-446d-96e9-9bb68072c951) | ![Bios3](https://github.com/user-attachments/assets/40526224-38e8-4a1f-893d-2fe187f7a69f) | ![Bios4](https://github.com/user-attachments/assets/c712919e-0e45-4589-a5bd-a9fec2800ccd) |

| BIOS Screen 5 | BIOS Screen 6 | BIOS Screen 7 |
| :---: | :---: | :---: |
| ![Bios5](https://github.com/user-attachments/assets/5efb5a20-a4f9-4778-91a5-fec73fb9c3f2) | ![Bios6](https://github.com/user-attachments/assets/d159f33f-7735-446b-9e95-7ec3cb08ad9b) | ![Bios7](https://github.com/user-attachments/assets/58853151-8973-464d-9974-97b9739824d9) |

</details>

---

## 🎨 Boot Logos & Customizations

### Official Release Logos
* **Bazzite OS Logo** (`release-0.1.2`)  
  ![BazziteOS](https://github.com/user-attachments/assets/78c5589a-7d55-4258-afc5-3232e62aeff0)
* **Steam Standard Logo** (`release-0.2.2`)  
  ![New SteamOS Logo-H](https://github.com/user-attachments/assets/6d3caf32-eb5c-414e-9587-2b91551c1b27)
* **Steam XL Scaling Logo** (`release-0.2.2`)  
  ![New SteamOS Logo-XL-H](https://github.com/user-attachments/assets/1543250b-020e-4c15-aa0a-e18aa2faa885)
* **CachyOS Logo** (`release-0.1.2`)  
  ![CachyOS](https://github.com/user-attachments/assets/be4010a0-1b65-45d2-aac1-7cb7c9e2b921)
* **Steam Graphic Wordmark** (`release-0.1.2`)  
  ![SteamOS Name](https://github.com/user-attachments/assets/e83674c2-69f6-42ab-930e-e21b8f19f37c)
* **AMD Standard Logo** (`release-0.1.2`)  
  ![AMD_BC-250 Logo](https://github.com/user-attachments/assets/ca23ce6c-08ab-4293-9a70-0e55f66dc93c)
* **AMD Logo (Monochrome White)** (`release-0.1.3`)  
  ![AMD_BC250-PW](https://github.com/user-attachments/assets/16b07f80-f9d5-450b-89e1-e7aad2f0a685)
* **SteamOS BlackOutCapsule v1** (`release-0.1.2`)  
  ![SteamOS Blackout](https://github.com/user-attachments/assets/58ee42be-fdb7-40ed-a67c-3030524d49e6)
* **SteamOS BlackOutCapsule v2** (`release-0.1.2`)  
  ![SteamOS Blackout 2](https://github.com/user-attachments/assets/9da39bae-88c3-441a-a3dc-015da9967bab)
* **Steam Standard Logo Wordmark** (`release-0.1.2`)  
  ![SteamOS+Name](https://github.com/user-attachments/assets/a11a85e4-9949-4b0d-a0ad-45456f8a4a36)
* **Steam Text (Glass Bubble Effect)** (`release-0.1.2`)  
  ![SteamOS Glass](https://github.com/user-attachments/assets/5212953b-fa52-4065-8e1a-9fde238ce3fb)
* **Steam Text (Frost Bubble Effect)** (`release-0.1.2`)  
  ![SteamOS Frost](https://github.com/user-attachments/assets/22258389-6170-41ba-9849-2404c4f6d12c)
* **BC250 Logo (Monochrome White)**  
  ![BC250 Logo](https://github.com/user-attachments/assets/57cbb3b7-09b0-4dc6-93c7-20a379172bea)

<details>
<summary><b>Hidden Bonus Logos</b> (<code>release-0.2.2</code>)</summary>
<br>

* **ATARI Logo**  
  ![BC-250-ATARI](https://github.com/user-attachments/assets/677efaa2-c8fa-4ce8-b8f3-80c31044f52d)
* **Weyland Logo**  
  ![BC-250-Weyland](https://github.com/user-attachments/assets/b922d910-adab-4e9d-81fd-bb9ba45f3a57)

</details>

---

### 🚧 Unreleased / Experimental Concepts
> [!NOTE]
> The following logos and screenshots are **not** included in any current public release.

<details>
<br>
  
* **Bulbasaur Concept**  
  ![Bulbasaur](https://github.com/user-attachments/assets/9237b5ff-961f-475c-9197-39ba1c46fb11)
* **Sylveon Concept**  
  ![Sylvion](https://github.com/user-attachments/assets/2397e7c8-b7ab-436c-8d08-636f59a69101)
* **Steam Steel Concept**  
  ![Steam Steel](https://github.com/user-attachments/assets/c0be5131-dfb9-4a4e-ab4e-6721a72a3161)
