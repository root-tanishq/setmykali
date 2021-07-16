#!/bin/bash
echo "
██╗░░██╗░█████╗░██╗░░░░░██╗  ██╗░░░░░██╗███╗░░██╗██╗░░░██╗██╗░░██╗
██║░██╔╝██╔══██╗██║░░░░░██║  ██║░░░░░██║████╗░██║██║░░░██║╚██╗██╔╝
█████═╝░███████║██║░░░░░██║  ██║░░░░░██║██╔██╗██║██║░░░██║░╚███╔╝░
██╔═██╗░██╔══██║██║░░░░░██║  ██║░░░░░██║██║╚████║██║░░░██║░██╔██╗░
██║░╚██╗██║░░██║███████╗██║  ███████╗██║██║░╚███║╚██████╔╝██╔╝╚██╗
╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚═╝  ╚══════╝╚═╝╚═╝░░╚══╝░╚═════╝░╚═╝░░╚═╝"
echo "Script is made by Boy From Future for more info https://github.com/root-tanishq"
echo ""
echo "The script will only work with root privileges (use sudo or root)"
echo ""
echo "Add a root password"
passwd root
echo ""
echo "Adding Fast Repository"
apt install apt-transport-https -y
echo "# See https://www.kali.org/docs/general-use/kali-linux-sources-list-repositories/
#deb http://http.kali.org/kali kali-rolling main contrib non-free

# Additional line for source packages
# deb-src http://http.kali.org/kali kali-rolling main contrib non-free

deb https://mirror-1.truenetwork.ru/kali kali-rolling main contrib non-free
deb-src https://mirror-1.truenetwork.ru/kali kali-rolling main contrib non-free 
" > /etc/apt/sources.list
echo "Repository Edited"
echo ""
echo "Updating Repository"
apt update
echo "Repository updated"
echo ""
echo "Do you want to add battery threshold(only for laptop)[y/n]:"
read install_bat
if [ "$install_bat" = "y" ];
then
        bat_thresh="@reboot     root    echo 80 > /sys/class/power_supply/BAT1/charge_control_end_threshold"
        echo $bat_thresh | tee /etc/crontab
        unset bat_thresh
else
        echo "battery threshold aborted"
fi
unset install_bat
echo "Do you have dual monitor and want to change lock screen to the main screen[y/n]:"
read install_lock
if [ "$install_lock" = "y" ];
then
        cp ~/.config/monitors.xml /var/lib/gdm3/.config
else
        echo ""
fi

echo "Enabling Bluetooth"
systemctl enable bluetooth.service
systemctl restart bluetooth.service
echo ""
echo "Fixing time in Kali Linux"
timedatectl set-local-rtc 1 --adjust-system-clock
echo ""
echo "Do you want to increase the mouse scroll speed[y/n]: "
read scroll_mouse
if [ "$scroll_mouse" = "y" ];
then
        apt install imwheel -y
        echo "".*"
None,      Up,   Button4, 3
None,      Down, Button5, 3
Control_L, Up,   Control_L|Button4
Control_L, Down, Control_L|Button5
Shift_L,   Up,   Shift_L|Button4
Shift_L,   Down, Shift_L|Button5" > ~/.imwheelrc
        imwheel -b "4 5"
        echo '@reboot     root    imwheel -b "4 5"' | tee /etc/crontab
else
        echo "Mouse scroll speed task aborted"
fi
unset scroll_mouse
 echo ""
echo "Do you want to install snap[y/n]:"
read install_snap
if [ "$install_snap" = "y" ];
then
        echo "Installing snap"
        apt install snapd -y
        systemctl enable --now snapd apparmor
        systemctl restart --now snapd apparmor
        echo ""
        echo "Do you want to install signal for desktop[y/n]:"
        read install_signal
        if [ "$install_signal" = "y" ];
        then
                echo "Install signal for desktop"
                snap install signal-desktop
        else
                echo "signal installation aborted"
        fi
        echo ""
        echo "Do you want to install discord[y/n]:"
        read install_discord
        if [ "$install_discord" = "y" ];
        then
                echo "Install discord for desktop"
                snap install discord
        else
                echo "discord installation aborted"
        fi
        echo ""
        echo "Do you want to install spotify[y/n]:"
        read install_spotify
        if [ "$install_spotify" = "y" ];
        then
                echo "Install spotify for desktop"
                snap install spotify
        else
                echo "spotify installation aborted"
        fi
else
        echo "Installing snap aborted"
fi
unset install_snap
unset install_signal
unset install_discord
unset install_spotify
echo ""
echo "Do you want to install Telegram[y/n]:"
read install_telegram
if [ "$install_telegram" = "y" ];
then 
        apt install telegram-desktop -y
        echo "Telegram installed"
else
        echo "Telegram installation aborted"
fi
unset install_telegram
echo ""
echo "Do you want to install Chrome Browser[y/n]:"
read install_chrome
if [ "$install_chrome" = "y" ];
then 
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        dpkg -i google-chrome-stable_current_amd64.deb
        echo "Chrome installed"
else
        echo "Chrome installation aborted"
fi
unset install_chrome
echo ""
echo "Do you want to install vscode[y/n]:"
read install_code
if [ "$install_code" = "y" ];
then 
        apt install code -y 
        echo "vscode installed"
else
        echo "vscode installation aborted"
fi
unset install_code
echo ""
echo "Do you want to install preload[y/n]:"
read install_preload
if [ "$install_preload" = "y" ];
then 
        apt install preload -y 
        echo "preload installed"
else
        echo "preload installation aborted"
fi
unset install_preload
echo ""
echo "Do you want to install Remmina[y/n]:"
read install_remmina
if [ "$install_remmina" = "y" ];
then 
        apt install remmina -y 
        echo "remmina installed"
else
        echo "remmina installation aborted"
fi
unset install_remmina
echo ""
echo "Do you want to install stacer[y/n]:"
read install_stacer
if [ "$install_stacer" = "y" ];
then 
        apt install stacer -y 
        echo "stacer installed"
else
        echo "stacer installation aborted"
fi
unset install_stacer
echo ""
echo "Do you want to install obs for desktop[y/n]:"
read install_obs
if [ "$install_obs" = "y" ];
then 
        apt install ffmpeg -y 
        apt install obs-studio -y 
        echo "obs installed"
else
        echo "obs installation aborted"
fi
unset install_obs
echo ""
echo "Do you want to install python3 pip[y/n]:"
read install_pip
if [ "$install_pip" = "y" ];
then 
        apt install python3-pip -y 
        echo "python3 pip installed"
else
        echo "python3 pip installation aborted"
fi
unset install_pip
echo ""
echo "Do you want to install seclists[y/n]:"
read install_seclists
if [ "$install_seclists" = "y" ];
then 
        apt install seclists -y 
        echo "seclists installed"
else
        echo "seclists installation aborted"
fi
unset install_seclists
echo ""
echo "Do you want to install Gobuster[y/n]:"
read install_gobuster
if [ "$install_gobuster" = "y" ];
then 
        apt install gobuster -y 
        echo "gobuster installed"
else
        echo "gobuster installation aborted"
fi
unset install_gobuster
echo ""
echo "Do you want to install Dirsearch[y/n]:"
read install_dirsearch
if [ "$install_dirsearch" = "y" ];
then 
        apt install dirsearch -y 
        echo "dirsearch installed"
else
        echo "dirsearch installation aborted"
fi
unset install_dirsearch
echo ""
echo "Do you want to upgrade kali linux [y/n]:"
read install_upgrade
if [ "$install_upgrade" = "y" ];
then 
        apt full-upgrade -y 
        echo "Kali Linux upgraded"
else
        echo "Kali linux upgradation aborted"
fi
unset install_upgrade
echo "Thank you for using this script"
echo "Made with <3 By Boy From Future"
echo ""
echo "Do you want to restart PC (suggested to restart if you upgraded)[y/n]:"
read wanna_restart
if [ "$wanna_restart" = "y" ];
then
        init 0
else
        echo ""
fi
