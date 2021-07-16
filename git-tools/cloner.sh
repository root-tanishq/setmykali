#!/bin/bash
printf "
\t\t █▀▀ █░░ █▀█ █▄░█ █▀▀ █▀█
\t\t █▄▄ █▄▄ █▄█ █░▀█ ██▄ █▀▄ \n\n"
echo "Script is made by Boy From Future for more info https://github.com/root-tanishq"
echo " "
echo "The script will only work with root privileges (use sudo or root)"
echo " "
echo "Installing git tool for debian"
apt install git -y
echo " "
echo "All tools will be placed in /opt/tools directory"
mkdir /opt/tools
select options in $(cat git-tools.txt); do
	cd /opt/tools; git clone https://github.com/$options
	echo "Repository cloned $options"
done