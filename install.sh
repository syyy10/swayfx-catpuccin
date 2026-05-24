#!/bin/bash
echo "     SwayFX Configuration Installer     "

# 2. Check for Arch (Added missing file check safeguard)
if [ ! -f /etc/os-release ] || ! grep -qE '^ID=arch|^ID_LIKE=.*arch' /etc/os-release; then
  echo "[*] This script only works on Arch Linux or Arch-based distros"
  exit 1
fi

echo " [*] Installing Dependencies"
if command -v paru >/dev/null 2>&1; then
	paru -S --noconfirm swayfx-git
else
	yay -S --noconfirm swayfx-git
fi

pacman -S --noconfirm sway waybar wofi pulseaudio networkmanager thunar kitty swaylock awww

# 4. Config replace (FIXED: Changed '~' to point to the actual user, added '-p' to mkdir)
# Note: Since the script runs as root, we must dynamically find the true user's home directory.
REAL_USER=${SUDO_USER:-$USER}
USER_HOME=$(eval echo ~$REAL_USER)

echo "[*] Replacing current configs for user: $REAL_USER"
mkdir -p "$USER_HOME/.config/sway"
mkdir -p "$USER_HOME/.config/kitty"
mkdir -p "$USER_HOME/.config/waybar"
mkdir -p "$USER_HOME/.config/wofi"

# Clean existing contents safely
rm -rf "$USER_HOME/.config/sway/"*
rm -rf "$USER_HOME/.config/kitty/"*
rm -rf "$USER_HOME/.config/waybar/"*
rm -rf "$USER_HOME/.config/wofi/"*

echo "[*] Installing new configs"
cp -r sway/* "$USER_HOME/.config/sway/"
cp -r kitty/* "$USER_HOME/.config/kitty/"
cp -r waybar/* "$USER_HOME/.config/waybar/"
cp -r wofi/* "$USER_HOME/.config/wofi/"

# Ensure the regular user owns their new config files
Har_OWNERSHIP_FIX=true
chown -R "$REAL_USER:$REAL_USER" "$USER_HOME/.config"

echo "[*] Installation complete, log out and enter sway"

