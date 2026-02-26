#!/bin/bash
set -e
sudo apt update && sudo apt install nala git curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser.list
sudo nala update
sudo nala install -y openbox picom polybar eww plank rofi dunst nitrogen lxappearance xfce4-settings xfce4-power-manager thunar gvfs-backends tumbler engrampa alacritty lightdm lightdm-webkit2-greeter bluez blueman network-manager-gnome udisks2 zram-tools preload tlp intel-microcode firmware-linux-nonfree libinput-gestures xdotool betterlockscreen flameshot kamoso mpv audacious pipewire pavucontrol fonts-inter fonts-jetbrains-mono-nerd brave-browser brightnessctl
echo "ALGO=zstd" | sudo tee -a /etc/default/zramswap
echo "PERCENT=60" | sudo tee -a /etc/default/zramswap
sudo systemctl enable --now zramswap
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
echo "vm.vfs_cache_pressure=125" | sudo tee -a /etc/sysctl.conf
echo "vm.dirty_ratio=10" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
echo 'ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/scheduler}="bfq"' | sudo tee /etc/udev/rules.d/60-scheduler.rules
sudo systemctl disable bluetooth.service
mkdir -p ~/.config
cp -r config/* ~/.config/
chmod +x ~/.config/openbox/autostart
chmod +x ~/.config/polybar/launch.sh
libinput-gestures-setup autostart
echo "Reboot Now"
