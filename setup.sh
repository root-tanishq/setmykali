#!/bin/bash
if [[ $EUID == 0 ]];then
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] root user detected";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo
export SMK_SUDO=''
elif [[ $(groups | grep -oP sudo) == "sudo" ]];then
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] sudo group detected";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo
export SMK_SUDO='sudo'
elif [[ $EUID != 0 && $(groups | grep -oP sudo) != "sudo" ]]; then
echo -e "[\033[0;31m❯\033[0;0m] root or sudo access required for setmykali installation \033[0;33m[root | sudo] \033[0;0m";
echo -e "[\033[0;31m❯\033[0;0m] if \033[1;33m'sudo'\033[0;0m is granted all the necessary customization changes will be done for \033[0;33mcurrent user \033[0;0m";
echo
exit
fi
$SMK_SUDO wget https://raw.githubusercontent.com/root-tanishq/setmykali/main/setmykali.sh -O /usr/local/bin/setmykali
$SMK_SUDO chmod +x /usr/local/bin/setmykali
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] Installation done use setmykali to use the tool";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"