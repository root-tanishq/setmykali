#!/bin/bash
#------------------------------------------------------------------------
# SetMyKali version 2.0
#------------------------------------------------------------------------


#------------------------------------------------------------------------
# Unsetting variables
#------------------------------------------------------------------------
function smk_unset_vars () {
for smk_unset in $(cat ~/.setmykali.bff | grep -v '#' | grep export | awk '{print $2}' | awk -F'=' '{print $1}');do
unset $smk_unset
done
}



#------------------------------------------------------------------------
#Ending Ctrl C Detection
#------------------------------------------------------------------------
function smk_trap_ctrlc ()
{
    echo
    echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
    echo -e "\033[0;36m|\033[0;0m[\033[1;31m!!❯\033[0;0m] Ctrl C Detected Would you like to exit."
    echo -e "\033[0;36m|\033[0;0m[\033[1;32m?❯\033[0;0m] Please select one option [\033[1;33mY\033[0;0m/N]."
    echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
    while [[ ${i_press_ctrl_c^^} != "Y" && ${i_press_ctrl_c^^} != "N" ]];do
    echo -ne "\033[0;36m|\033[0;0m"
    read -p "[??❯]smk> " i_press_ctrl_c
    done
    if [[ ${i_press_ctrl_c^^} == "Y" ]];then
    echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
    echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Thankyou for using setmykali.";
    echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
    smk_unset_vars
    exit 2
    fi
}
trap "smk_trap_ctrlc" 2




#------------------------------------------------------------------------
# Positional Parameter options 
#------------------------------------------------------------------------
case $1 in
  --help | -h | help | -help)
    # Display Help
   echo  -e "\033[0;36m
█▀ █▀▀ ▀█▀ █▀▄▀█ █▄█ █▄▀ ▄▀█ █░░ █
▄█ ██▄ ░█░ █░▀░█ ░█░ █░█ █▀█ █▄▄ █"
   echo
   echo "SetMyKali Positional Parameter help."
   echo
   echo -e "\033[1;31moptions:"
   echo -e "\033[1;33m--help|-h|help|-help\033[0;0m     Print this help."
   echo -e "\033[1;33m--resetcfg\033[0;0m     		 Reset SetMyKali config to default."
   echo -e "\033[1;33m--nologo\033[0;0m     		 Don't print logo."
   echo -e "\033[1;33m--repofix\033[0;0m     		 Fixes repository based issuse."
   echo -e "\033[1;33m--apti\033[0;0m     		 Install apt software parse by a (file of apt softwares)."
   echo -e "\033[1;33m--install\033[0;0m     		 Install SetMyKali tool."
   echo
   exit
    ;;
  --install)
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
  echo -e "[\033[0;31m❯\033[0;0m] root or sudo access required for setmykali \033[0;33m[root | sudo] \033[0;0m";
  echo -e "[\033[0;31m❯\033[0;0m] if \033[1;33m'sudo'\033[0;0m is granted all the necessary customization changes will be done for \033[0;33mcurrent user \033[0;0m";
  echo
  exit
  fi
  $SMK_SUDO rm -f /usr/local/bin/setmykali >/dev/null
  $SMK_SUDO cp -f $0 /usr/local/bin/setmykali
  $SMK_SUDO chmod +x /usr/local/bin/setmykali
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] use \033[0;33m| ❯ setmykali | \033[0;0m for using the tool";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  exit
  ;;
  --apti)
  # Checking for super user permissions
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
  echo -e "[\033[0;31m❯\033[0;0m] root or sudo access required for setmykali \033[0;33m[root | sudo] \033[0;0m";
  echo -e "[\033[0;31m❯\033[0;0m] if \033[1;33m'sudo'\033[0;0m is granted all the necessary customization changes will be done for \033[0;33mcurrent user \033[0;0m";
  echo
  exit
  fi
  # checking if file parsed and exist
  if [[ -e $2 ]];then
  $SMK_SUDO apt install fzf -y 
  for install_param_apti in $(cat $2);do
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] Installing \033[0;33m$install_param_apti \033[0;0m";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo 
  $SMK_SUDO apt install $install_param_apti -y
  done
  else
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "[\033[0;31m❯\033[0;0m] could not load file \033[0;33m$2 \033[0;0m";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  fi
  exit
  ;;
  --resetcfg)
  	echo -e "[\033[0;32m❯\033[0;0m] Reseting SetMyKali Configuration to Default"
  	echo '# CONFIGURATION OF SETMYKALI TOOL
# https://github.com/root-tanishq/setmykali
# In Order to restore setmykali settings delete this file 
# use capital "Y" in order for using the particular variable in the configuration
export SMK_LOGO="Y"'  2>/dev/null > ~/.setmykali.bff;
	if [[ $(cat ~/.setmykali.bff | md5sum | awk '{print $1}') == "3946b6c68798d3d2c821e7cedc2c14d2" ]];then
	echo -e "[\033[0;32mSUCCESS❯\033[0;0m] Configuration reset success"
	else
	echo -e "[\033[0;31mFAIL❯\033[0;0m] Configuration reset failure"
	fi
    exit
    ;;
  --repofix)
  if [[ $(cat /etc/os-release | grep '^ID=' | awk -F'=' '{print $2}') == 'kali' ]];then
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] Kali Linux detected";
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
  echo -e "[\033[0;31m❯\033[0;0m] root or sudo access required for setmykali \033[0;33m[root | sudo] \033[0;0m";
  echo -e "[\033[0;31m❯\033[0;0m] if \033[1;33m'sudo'\033[0;0m is granted all the necessary customization changes will be done for \033[0;33mcurrent user \033[0;0m";
  echo
  exit
  fi
  $SMK_SUDO echo "deb http://http.kali.org/kali kali-rolling main contrib non-free
deb-src http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list
  $SMK_SUDO apt update
  echo -e "\n\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo
  else 
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] Kali Linux Not detected";
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
  echo -e "[\033[0;31m❯\033[0;0m] root or sudo access required for setmykali \033[0;33m[root | sudo] \033[0;0m";
  echo -e "[\033[0;31m❯\033[0;0m] if \033[1;33m'sudo'\033[0;0m is granted all the necessary customization changes will be done for \033[0;33mcurrent user \033[0;0m";
  echo
  exit
  fi
  echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] Installing kali repository using SECDEB";
  $SMK_SUDO echo "deb [trusted=true] https://http.kali.org/kali kali-rolling main contrib non-free
deb-src [trusted=true] http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
  $SMK_SUDO apt update
  echo -e "\n\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo
  fi
  exit
  ;;
esac






#------------------------------------------------------------------------
# For complete interactive setmykali session
#------------------------------------------------------------------------
clear -x 
echo ""



#------------------------------------------------------------------------
# Checking for the configuration
#------------------------------------------------------------------------
if [[ -e ~/.setmykali.bff ]];then
echo -e "[\033[0;32m❯\033[0;0m] Configuration Detected \033[0;33m~/.setmykali.bff \033[0;0m";
source ~/.setmykali.bff;
else
echo '# CONFIGURATION OF SETMYKALI TOOL
# https://github.com/root-tanishq/setmykali
# In Order to restore setmykali settings delete this file 
# use capital "Y" in order for using the particular variable in the configuration
export SMK_LOGO="Y"' > ~/.setmykali.bff;
export SMK_LOGO="Y"
export SMK_INSTRUCTION="N"
echo -e "[\033[0;32m❯\033[0;0m] Configuration Created \033[0;33m~/.setmykali.bff \033[0;0m";
fi



#------------------------------------------------------------------------
# SetMyKali Logo 
# Checking for nologo
#------------------------------------------------------------------------
if [[ $1 == "--nologo" ]];then
export SMK_LOGO="NOLOGO"
fi


#------------------------------------------------------------------------
# printing logo
#------------------------------------------------------------------------
if [[ ${SMK_LOGO^^} == "Y" ]]; then
#------------------------------------------------------------------------
# main logo
#------------------------------------------------------------------------
echo -e "\n\n\n\n\n\n"
echo -e "\033[0;36m
   ▄████████    ▄████████     ███       ▄▄▄▄███▄▄▄▄   ▄██   ▄      ▄█   ▄█▄    ▄████████  ▄█        ▄█  
  ███    ███   ███    ███ ▀█████████▄ ▄██▀▀▀███▀▀▀██▄ ███   ██▄   ███ ▄███▀   ███    ███ ███       ███  
  ███    █▀    ███    █▀     ▀███▀▀██ ███   ███   ███ ███▄▄▄███   ███▐██▀     ███    ███ ███       ███▌ 
  ███         ▄███▄▄▄         ███   ▀ ███   ███   ███ ▀▀▀▀▀▀███  ▄█████▀      ███    ███ ███       ███▌ 
▀███████████ ▀▀███▀▀▀         ███     ███   ███   ███ ▄██   ███ ▀▀█████▄    ▀███████████ ███       ███▌ 
         ███   ███    █▄      ███     ███   ███   ███ ███   ███   ███▐██▄     ███    ███ ███       ███  
   ▄█    ███   ███    ███     ███     ███   ███   ███ ███   ███   ███ ▀███▄   ███    ███ ███▌    ▄ ███  
 ▄████████▀    ██████████    ▄████▀    ▀█   ███   █▀   ▀█████▀    ███   ▀█▀   ███    █▀  █████▄▄██ █▀   
                                                                  ▀                      ▀              
\033[0;0m[\033[1;36m:::::::::::::: \033[1;33mSetMyKali ❯\033[0;0m A script for solving common issues and helps in configuring kali linux \033[1;36m::::::::::::::\033[0;0m ]
\033[0;0m
[\033[0;32m❯\033[0;0m] Created with <3 by \033[0;33mBoyFromFuture \033[0;0m
[\033[0;32m❯\033[0;0m] \033[0;33mGithub  ❯ \033[0;0mhttps://github.com/root-tanishq/setmykali
[\033[0;32m❯\033[0;0m] \033[0;33mTwitter ❯ \033[0;0mhttps://twitter.com/root_tanishq
"
echo -e "\n\n"
#------------------------------------------------------------------------
# Loading screen
#------------------------------------------------------------------------
echo -ne '\033[0;0m[\033[0;33m10%\033[0;0m]\033[0;0m |\033[0;33m▇▇▇▇▇▇▇▇▇▇\033[0;0m|\r'
sleep 0.1
echo -ne '\033[0;0m[\033[0;33m20%\033[0;0m]\033[0;0m |\033[0;33m▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇\033[0;0m|\r'
sleep 0.1
echo -ne '\033[0;0m[\033[0;33m30%\033[0;0m]\033[0;0m |\033[0;33m▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇\033[0;0m|\r'
sleep 0.1
echo -ne '\033[0;0m[\033[0;33m40%\033[0;0m]\033[0;0m |\033[0;33m▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇\033[0;0m|\r'
sleep 0.1
echo -ne '\033[0;0m[\033[0;33m50%\033[0;0m]\033[0;0m |\033[0;33m▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇\033[0;0m|\r'
sleep 0.1
echo -ne '\033[0;0m[\033[0;33m60%\033[0;0m]\033[0;0m |\033[0;33m▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇\033[0;0m|\r'
sleep 0.1
echo -ne '\033[0;0m[\033[0;33m70%\033[0;0m]\033[0;0m |\033[0;33m▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇\033[0;0m|\r'
sleep 0.1
echo -ne '\033[0;0m[\033[0;33m80%\033[0;0m]\033[0;0m |\033[0;33m▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇\033[0;0m|\r'
sleep 0.1
echo -ne '\033[0;0m[\033[0;33m90%\033[0;0m]\033[0;0m |\033[0;33m▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇\033[0;0m|\r'
sleep 0.1
echo -ne '\033[0;0m[\033[0;33m100%\033[0;0m]\033[0;0m |\033[0;33m▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇\033[0;0m|\r'
sleep 0.1
echo -ne '\033[0;0m[\033[0;33mSetMyKali\033[0;0m]\033[0;0m |\033[0;33m▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇\033[0;0m|\r\n'
echo -e "\r\n"
#------------------------------------------------------------------------
# Logo Complete
#------------------------------------------------------------------------
fi




#------------------------------------------------------------------------
# Checking for super user access
#------------------------------------------------------------------------
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
echo -e "[\033[0;31m❯\033[0;0m] root or sudo access required for setmykali \033[0;33m[root | sudo] \033[0;0m";
echo -e "[\033[0;31m❯\033[0;0m] if \033[1;33m'sudo'\033[0;0m is granted all the necessary customization changes will be done for \033[0;33mcurrent user \033[0;0m";
echo
exit
fi



#------------------------------------------------------------------------
# Checking for Internet Connection
#------------------------------------------------------------------------
if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
echo 
else
echo -e "\033[0;36m|-----------------------------------------------------------------
|\033[1;33m!!❯\033[1;31m Internet Connection is required to run SetMyKali\033[0;36m
|-----------------------------------------------------------------"
exit
fi



#------------------------------------------------------------------------
# Instructions asking
#------------------------------------------------------------------------
if [[ ${SMK_INSTRUCTION^^} != "Y" ]];then
echo -e "\033[0;36m|-----------------------------------------------------------------
|\033[1;33m❯❯\033[1;31m INSTRUCTIONS\033[0;36m
|-----------------------------------------------------------------
|\033[0;0mHello $(whoami),
\033[0;36m|\033[0;0m\tI am BoyFromFuture and this script is created for helping
\033[0;36m|\033[0;0min configuring kali linux after initial installation.If your
\033[0;36m|\033[0;0mkali linux is working fine please don't use the \033[1;33m1st time setup 
\033[0;36m|\033[0;0moption in configuration.
\033[0;36m|\033[0;0mThankyou for using setmykali.
\033[0;36m|\033[0;0mYou can contribute to the project by smiling and providing 
\033[0;36m|\033[0;0mfurther ideas to add in script.
\033[0;36m|\033[0;0mYou may contact me on twitter.
\033[0;36m|\033[1;33mTwitter ❯\033[0;0m https://twitter.com/root_tanishq
\033[0;36m|-----------------------------------------------------------------"
echo -e "|\033[0;0m[\033[0;32m??❯\033[0;0m] Do you wish to continue[\033[1;33mY\033[0;0m/N]"
while [[ ${i_agree_smk_instructions^^} != "Y" && ${i_agree_smk_instructions^^} != "N" ]];do
echo -ne "\033[0;36m|\033[0;0m"
read -p "[??❯]smk> " i_agree_smk_instructions 
done
if [[ ${i_agree_smk_instructions^^} == "Y" ]];then
echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] Thankyou for accepting instructions"
echo 'export SMK_INSTRUCTION="Y"' >> ~/.setmykali.bff
echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] Your choice is recorded in configuration file"
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
else
echo -e "\033[0;36m|\033[0;0m[\033[0;31m!❯\033[0;0m] Instructions wizard rejected"
echo -e "\033[0;36m|\033[0;0m[\033[0;31m!❯\033[0;0m] This wizard will always run with setmykali"
echo -e "\033[0;36m|\033[0;0m[\033[0;31m!❯\033[0;0m] No changes created in the configuration file"
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
fi
unset $i_agree_smk_instructions
fi

#------------------------------------------------------------------------
# Checking for kali linux
#------------------------------------------------------------------------
if [[ $(cat /etc/os-release | grep '^ID=' | awk -F'=' '{print $2}') == 'kali' ]];then
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] Kali Linux detected";
echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] SecDeb will not be used during '1st time setup'";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo
export SMK_SECDEB='N'
else 
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] Kali Linux not detected";
echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] Installing Kali repository with SecDeb";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo
export SMK_SECDEB='Y'
fi




#------------------------------------------------------------------------
# Functions for SetMyKali
#------------------------------------------------------------------------



#------------------------------------------------------------------------
# Creator Information
#------------------------------------------------------------------------
function smk_creator_info ()
{
clear -x 
echo -e '\033[1;36m
    ____              ______                     ______      __                
   / __ )____  __  __/ ____/________  ____ ___  / ____/_  __/ /___  __________ 
  / __  / __ \/ / / / /_  / ___/ __ \/ __ `__ \/ /_  / / / / __/ / / / ___/ _ \
 / /_/ / /_/ / /_/ / __/ / /  / /_/ / / / / / / __/ / /_/ / /_/ /_/ / /  /  __/
/_____/\____/\__, /_/   /_/   \____/_/ /_/ /_/_/    \__,_/\__/\__,_/_/   \___/ 
            /____/                                                             
\033[0;0m
'
echo -e "[\033[1;33mCREATOR ❯\033[0;0m] Tanishq Rathore (\033[0;33mBoyFromFuture\033[0;0m)"
echo
echo -e "[\033[1;33mTwitter ❯\033[0;0m] https://twitter.com/root_tanishq "
echo
echo -e "[\033[1;33mGithub ❯\033[0;0m] https://github.com/root-tanishq/ "
echo
echo -e "[\033[1;33mGithub.io ❯\033[0;0m] https://root-tanishq.github.io/ "
echo
echo -e "[\033[1;33mLinkedIn ❯\033[0;0m] https://www.linkedin.com/in/tanishq-rathore-115033202/ "
echo
echo -e "[\033[1;33mMedium ❯\033[0;0m] https://tanishqrathore.medium.com/ "
echo
echo -e "[\033[1;33mYouTube ❯\033[0;0m] https://www.youtube.com/channel/UC0HLRnmOx3x_hsAGAdG9VaQ "
echo
echo -e "[\033[1;33mOther Github Project ❯\033[0;0m] https://github.com/root-tanishq/autorev.sh "
echo
echo -e "[\033[1;33mOpen Expy Link ❯\033[0;0m] (\033[1;34mVerified✅\033[0;0m) [\033[1;33mY\033[0;0m/N]"
while [[ ${smk_creator_info_redir^^} != "Y" && ${smk_creator_info_redir^^} != "N" ]];do
    read -p "[??❯]smk> " smk_creator_info_redir
    done
if [[ ${smk_creator_info_redir^^} == "Y" ]];then
    firefox expy.bio/tanishq
    fi
unset smk_creator_info_redir
}




#------------------------------------------------------------------------
# Main Option Help menu
#------------------------------------------------------------------------
function smk_main_sec_help () {
  echo  -e "\033[0;36m
█▀ █▀▀ ▀█▀ █▀▄▀█ █▄█ █▄▀ ▄▀█ █░░ █
▄█ ██▄ ░█░ █░▀░█ ░█░ █░█ █▀█ █▄▄ █"
   echo
   echo "SetMyKali Main Section Help Menu."
   echo
   echo -e "\033[1;31moptions:"
   echo -ne "\033[0;36m|---------------------------------------------------------------------------------------------------------\n|\033[0;0m"
   echo -e "\033[1;33m1st time setup\033[0;0m\t\t\t\tSetup all 1st time installation necessary things."
   echo -ne "\033[0;36m|---------------------------------------------------------------------------------------------------------\n|\033[0;0m"
   echo -e "\033[1;33mApplication Install\033[0;0m\t\t\tInstall Applications (you can use custom apt list with --apti )."
   echo -ne "\033[0;36m|---------------------------------------------------------------------------------------------------------\n|\033[0;0m"
   echo -e "\033[1;33mCustomization\033[0;0m\t\t\t\tCustomize tools (vim tmux zsh bash)."
   echo -ne "\033[0;36m|---------------------------------------------------------------------------------------------------------\n|\033[0;0m"
   echo -e "\033[1;33mUpgrade Kali\033[0;0m\t\t\t\tUpgrade kali linux to its latest release."
   echo -ne "\033[0;36m|---------------------------------------------------------------------------------------------------------\n|\033[0;0m"
   echo -e "\033[1;33mhelp\033[0;0m\t\t\t\t\tPrint this help."
   echo -ne "\033[0;36m|---------------------------------------------------------------------------------------------------------\n|\033[0;0m"
   echo -e "\033[1;33mCreator Information\033[0;0m\t\t\tPrint Creator Information."
   echo -ne "\033[0;36m|---------------------------------------------------------------------------------------------------------\n|\033[0;0m"
   echo -e "\033[1;33mCommon Fixes\033[0;0m\t\t\t\tresolve commonly occuring issues in kali linux."
   echo -ne "\033[0;36m|---------------------------------------------------------------------------------------------------------\033[0;0m"
   echo
}




#------------------------------------------------------------------------
# 1st time setup
#------------------------------------------------------------------------
function first_time_setup () {
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] 1st time usage .";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Set Root Password.";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
passwd root
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Adding kali repository";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
if [[ ${SMK_SECDEB^^} == 'N' ]];then
$SMK_SUDO echo "deb http://http.kali.org/kali kali-rolling main contrib non-free
deb-src http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list
$SMK_SUDO apt update
echo -e "\n\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo
else
echo -e "\033[0;36m|\033[0;0m[\033[0;32m❯\033[0;0m] Installing kali repository using SECDEB";
$SMK_SUDO echo "deb [trusted=true] https://http.kali.org/kali kali-rolling main contrib non-free
deb-src [trusted=true] http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
$SMK_SUDO apt update
echo -e "\n\033[0;36m|-----------------------------------------------------------------\033[0;0m"
fi
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Adding https support for repository";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
$SMK_SUDO apt install apt-transport-https -y
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Enabling bluetooth";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
$SMK_SUDO systemctl enable bluetooth.service
$SMK_SUDO systemctl restart bluetooth.service
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Setting local time to kali linux";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
timedatectl set-local-rtc 1 --adjust-system-clock
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] 1st time setup completed";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
}




#------------------------------------------------------------------------
# Common linux related issues and their fixes
#------------------------------------------------------------------------
function smk_common_fixes () {
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Common Fixes Section";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
PS3=$(echo -e "\n[\033[0;32m?❯\033[0;0m] SetMyKali Common Fixes Section\033[1;33m>\033[0;0m ")
smk_common_probs=("AMD Screen tearing issue" "Nvidia graphic driver install" "Copy Paste issue to external drives" "Slow Mouse Wheel" "help" "Battery threshold at 80 for Laptop" "Go to Main Section" "Quit")
select smk_common_probs_opt in "${smk_common_probs[@]}"
do
case $smk_common_probs_opt in
  "AMD Screen tearing issue")
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Installing Fix to kali linux.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo 'Section "Device"
        Identifier "AMD"
        Driver  "amdgpu"
        Option "TearFree" "true"
EndSection
' | $SMK_SUDO tee /etc/X11/xorg.conf.d/20-amdgpu.conf
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Restart PC for changes implementation.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  ;;
  "Nvidia graphic driver install")
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Follow the blog to install nvidia drivers properly.";
  echo -ne "\033[0;36m|-----------------------------------------------------------------\n|\033[0;0m"
  echo "https://linuxconfig.org/how-to-install-nvidia-drivers-on-kali-linux"
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  ;;
  "Copy Paste issue to external drives")
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Adding a cron job to fix the issue.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo "@reboot root echo \$((16*1024*1024)) > /proc/sys/vm/dirty_background_bytes
@reboot root echo \$((48*1024*1024)) > /proc/sys/vm/dirty_bytes" | $SMK_SUDO tee -a /etc/crontab
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Restart PC for changes implementation.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  ;;
  "Slow Mouse Wheel")
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Installing utlity.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  $SMK_SUDO apt install imwheel -y
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Adding a cron job to fix the issue.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo '".*"
None,      Up,   Button4, 3
None,      Down, Button5, 3
Control_L, Up,   Control_L|Button4
Control_L, Down, Control_L|Button5
Shift_L,   Up,   Shift_L|Button4
Shift_L,   Down, Shift_L|Button5' > ~/.imwheelrc
  echo '@reboot     root    imwheel -b "4 5"' | $SMK_SUDO tee -a /etc/crontab
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Restart PC for changes implementation.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  ;;
  "Battery threshold at 80 for Laptop")
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Adding a cron job for battery threshold.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  if [ -d sys/class/power_supply/BAT1 ];
    then
    bat_thresh="@reboot     root    echo 80 > /sys/class/power_supply/BAT1/charge_control_end_threshold"
      echo $bat_thresh | $SMK_SUDO tee -a /etc/crontab
      unset bat_thresh
    else
      bat_thresh="@reboot     root    echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold"
      echo $bat_thresh | $SMK_SUDO tee -a /etc/crontab
      unset bat_thresh 
  fi
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Restart PC for changes implementation.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  ;;
  "help")
    echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
    echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] HELP for SetMyKali Custom Fixes Section";
    echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
    echo -e "\033[0;36m|\033[0;0m[\033[1;33mCommand ❯\033[0;0m] Information";
    echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ 1\033[0;0m] Fixes screen tearing issues in AMD based PC";
    echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ 2\033[0;0m] Installation guide for nvidia graphic cards ";
    echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ 3\033[0;0m] Dirty bytes copy paste issue in external hard disk";
    echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ 4\033[0;0m] Slow mouse wheel scrolling issue";
    echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ 5\033[0;0m] Print this help";
    echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ 6\033[0;0m] Stops laptop charging at 80 (only on laptop)";
    echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  ;;
  "Go to Main Section")
    echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
    echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Exited Common fixes section.";
    echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
    PS3=$(echo -e "\n[\033[0;32m?❯\033[0;0m] SetMyKali Main Section\033[1;33m>\033[0;0m ")
    break
  ;;
  "Quit")
    echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
    echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Thankyou for using setmykali.";
    echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
    exit
  ;;
esac
done
}






#------------------------------------------------------------------------
# Upgrade Kali Linux function main usage
#------------------------------------------------------------------------
function smk_upgrade_kali () {
if [[ ${SMK_SECDEB^^} == 'N' ]];then
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Upgrading Kali Linux.";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
$SMK_SUDO apt full-upgrade -y
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Make sure to restart your computer.";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
else
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;31m❯\033[0;0m] As you are not using kali linux ,I doesn't recommend you to upgrade your system.";
echo -e "\033[0;36m|\033[0;0m[\033[1;31m❯\033[0;0m] If you still wish to upgrade ,then please remove the kali linux repository .";
echo -e "\033[0;36m|\033[0;0m[\033[1;31m❯\033[0;0m] and run the following command \033[1;32m❯ ${SMK_SUDO} apt update -y \033[0;0m.";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
fi
}




#------------------------------------------------------------------------
# Customization
#------------------------------------------------------------------------
function smk_customization () {
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] SetMyKali Customization Section.";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
PS3=$(echo -e "\n[\033[0;32m?❯\033[0;0m] SetMyKali Customization Section\033[1;33m>\033[0;0m ")
smk_custom_options=("Vim Customization" "Tmux Customization" "Zsh Customization" "Bash Customization" "Custom bind key and alias" "Wallpaper" "Reset Setting" "help" "Goto Main Section" "Quit")
select smk_custom_opts in "${smk_custom_options[@]}"
do
case $smk_custom_opts in
"Vim Customization")
$SMK_SUDO apt install vim -y 
cp -f ~/.vimrc ~/.vimrc.smk
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Please don't delete ~/.vimrc.smk";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
mkdir -p ~/.vim/pack/plugins/start/
$SMK_SUDO apt install  vim-gtk3
git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/plugins/start/lightline 
echo "IiBGb3IgU3ludGF4IEhpZ2hsaWdodGluZwpzeW50YXggb24KIiB1c2FibGl0eQpzZXQgYXV0b2luZGVudApzZXQgc21hcnRpbmRlbnQKc2V0IG51bWJlcgpzZXQgbW91c2U9YQoiIFRvIENvcHkgaW50byBnbm9tZSBzeXN0ZW0gQ2xpcGJvYXJkCnZtYXAgPEMteT4gIit5CiIgT3RoZXIgdXNlZnVsCnNldCBsYXN0c3RhdHVzPTIKc2V0IG5vc2hvd21vZGUKIiBGb3IgdG11eCB0byBsb2FkIGxpZ2h0bGluZQppZiAhaGFzKCdndWlfcnVubmluZycpCiAgc2V0IHRfQ289MjU2CiAgZW5kaWYKIiBWaXN1YWwgYmxvY2sgaGlnaGxpZ2h0aW5nIGZpeHR1cmUgZm9yIHRtdXgKaGlnaGxpZ2h0IFZpc3VhbCBjdGVybT1yZXZlcnNlIGN0ZXJtYmc9Tk9ORQoiIHNwZWNpYWwgY2hhcmFjdGVycyBoaWdobGlnaHQKc2V0IGxpc3QKc2V0IGxpc3RjaGFycz1lb2w6JCx0YWI6Pi0sdHJhaWw6fixleHRlbmRzOj4scHJlY2VkZXM6PAoiIHRhYmUgb24gdXBwZXIgc2lkZQpzZXQgc2hvd3RhYmxpbmU9Mgo=" | base64 -d  > ~/.vimrc
echo "This vim windows is for demonstraton purpose
Close the window by pressing 
Shift+Z Shift+Q on keyboard" | /usr/bin/vim -
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] SetMyKali is using lightline theme.";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Setuped Vim.";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
;;
"Tmux Customization")
$SMK_SUDO apt install tmux -y
cp -f ~/.tmux.conf ~/.tmux.conf.smk
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Please don't delete ~/.tmux.conf.smk";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
mkdir ~/.tmux-themepack
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack 
echo "c2V0IC1nIGhpc3RvcnktbGltaXQgMTAwMDAwCnNldCAtZyBhbGxvdy1yZW5hbWUgb2ZmCgpzZXQtd2luZG93LW9wdGlvbiAtZyBtb2RlLWtleXMgdmkKIyBUbXV4IExvZ2dpbmcgUGx1Z2dpbgojIHByZWZpeCArIFNoaWZ0ICsgQWx0ICsgcAojIHByZWZpeCArIEFsdCArIHAKcnVuLXNoZWxsIC9vcHQva2lyYS10b29scy90bXV4L3RtdXgtbG9nZ2luZy9sb2dnaW5nLnRtdXgKIyBUbXV4IFNpZGVCYXIgUGx1Z2luCiMgdXNlIHByZWZpeCArIFRhYiBvciBQcmVmaXggKyBCYWNrc3BhY2UKcnVuLXNoZWxsIC9vcHQva2lyYS10b29scy90bXV4L3RtdXgtc2lkZWJhci9zaWRlYmFyLnRtdXgKCnNldCAtcyBlc2NhcGUtdGltZSAwCgojVG11eCBMb2dnaW5nCmJpbmQta2V5IEggcGlwZS1wYW5lICJleGVjIGNhdCA+PiQocHdkKS8uTE9HUy0jSC0jSS0jUy0jVy0jUC10bXV4LSQoc2h1ZiAtaSAxMTExLTk5OTkgLW4xIHwgbWQ1c3VtIHwgaGVhZCAtYyAyMCkubG9nIiBcOyBkaXNwbGF5LW1lc3NhZ2UgJ1N0YXJ0ZWQgbG9nZ2luZyB0byAuTE9HUy0jSC0jSS0jUy0jVy0jUC10bXV4LmxvZycKYmluZC1rZXkgaCBwaXBlLXBhbmUgIFw7IGRpc3BsYXktbWVzc2FnZSAnRW5kZWQgbG9nZ2luZyB0byAuTE9HUy0jSC0jSS0jUy0jVy0jUC10bXV4LmxvZycKIyBVc2UgJCBsZXNzIC1mIC1yIGxvZ2ZpbGUubG9nIG9yIGNhdCBsb2dmaWxlLmxvZwoKIyBVc2UgQWx0LWFycm93IGtleXMgd2l0aG91dCBwcmVmaXgga2V5IHRvIHN3aXRjaCBwYW5lcwpiaW5kIC1uIE0tTGVmdCBzZWxlY3QtcGFuZSAtTApiaW5kIC1uIE0tUmlnaHQgc2VsZWN0LXBhbmUgLVIKYmluZCAtbiBNLVVwIHNlbGVjdC1wYW5lIC1VCmJpbmQgLW4gTS1Eb3duIHNlbGVjdC1wYW5lIC1ECgojIFNoaWZ0IGFycm93IHRvIHN3aXRjaCB3aW5kb3dzCmJpbmQgLW4gUy1MZWZ0ICBwcmV2aW91cy13aW5kb3cKYmluZCAtbiBTLVJpZ2h0IG5leHQtd2luZG93CgojIFpvb20gaW4gdG11eApiaW5kIC1uIE0teCByZXNpemUtcGFuZSAtWgoKIyBDb3B5IE1vZGUgaW4gdG11eCBrZXkKI2JpbmQta2V5IC1uIE0tYyBjb3B5LW1vZGUKCiMgQ29sb3IgaW4gdG11eCAKc291cmNlLWZpbGUgJHtIT01FfS8udG11eC10aGVtZXBhY2svcG93ZXJsaW5lL2RlZmF1bHQvY3lhbi50bXV4dGhlbWUKCiMgTW91c2UgSW50ZXJhY3Rpb24KI3NldHcgLWcgbW91c2Ugb24KCiMgWlNIIApzZXQgLWcgZGVmYXVsdC10ZXJtaW5hbCAieHRlcm0tMjU2Y29sb3IiCg==" | base64 -d > ~/.tmux.conf
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] SetMyKali is using tmux-themepack for customization.";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] All Necessary Instructions are in ~/.tmux.conf";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Following window is for testing and visual purposes";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Do Not Close the Window";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
sleep 3 
tmux new -s BOT -d
tmux rename-window -t "BOT.0" 'SetMyKali Testing'
tmux send-keys -t "BOT" C-z 'echo' Enter
tmux send-keys -t "BOT" C-z 'clear; sleep 10; tmux kill-session -t BOT' Enter
tmux new-window -t "BOT" -n 'SetMyKali is using tmux-themepack for the customization'
tmux attach -t "BOT"
;;
"Zsh Customization")
$SMK_SUDO apt install zsh -y 
cp -f ~/.zshrc ~/.zshrc_c.smk
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Please don't delete ~/.zshrc_c.smk";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] SetMyKali is using OhMyZsh for customization";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Type exit in zsh shell to get back to customization section of SetMyKali";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$SMK_SUDO usermod -s /bin/zsh $(whoami)
;;
"Bash Customization")
cp -f ~/.bashrc ~/.bashrc_c.smk
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Please don't delete ~/.bashrc_c.smk";
echo "IyBSb2JieSBSdXNzZWwgRm9yIEJhc2gKcHJvbXB0X2V4aXRjb2RlKCkgewogICAgW1sgJGV4aXRDb2RlIC1lcSAwIF1dICYmIHByb21wdCs9IlxbXGVbMTszMm1cXSIgJiYgcmV0dXJuCiAgICBwcm9tcHQrPSJcW1xlWzE7MzFtXF0iCn0KCnByb21wdF9naXQoKSB7CiAgICBicmFuY2g9YGdpdCBicmFuY2ggMj4gL2Rldi9udWxsIHwgc2VkIC1lICcvXlteKl0vZCcgLWUgJ3MvKiBcKC4qXCkvXDEvJ2AKICAgIGlmIFtbIC1uICIkYnJhbmNoIiBdXTsgdGhlbgogICAgICAgIHN0YXR1cz0iJChnaXQgc3RhdHVzIDI+JjEgfCB0ZWUpIgogICAgICAgIGJpdHM9IiIKICAgICAgICBlY2hvIC1uICIkc3RhdHVzIiAyPiAvZGV2L251bGwgfCBncmVwICJyZW5hbWVkOiIgJj4gL2Rldi9udWxsICYmIGJpdHMrPSI+IgogICAgICAgIGVjaG8gLW4gIiRzdGF0dXMiIDI+IC9kZXYvbnVsbCB8IGdyZXAgIllvdXIgYnJhbmNoIGlzIGFoZWFkIG9mIiAmPiAvZGV2L251bGwgJiYgYml0cys9IioiCiAgICAgICAgZWNobyAtbiAiJHN0YXR1cyIgMj4gL2Rldi9udWxsIHwgZ3JlcCAibmV3IGZpbGU6IiAmPiAvZGV2L251bGwgJiYgYml0cys9IisiCiAgICAgICAgZWNobyAtbiAiJHN0YXR1cyIgMj4gL2Rldi9udWxsIHwgZ3JlcCAiVW50cmFja2VkIGZpbGVzIiAmPiAvZGV2L251bGwgJiYgYml0cys9Ij8iCiAgICAgICAgZWNobyAtbiAiJHN0YXR1cyIgMj4gL2Rldi9udWxsIHwgZ3JlcCAiZGVsZXRlZDoiICY+IC9kZXYvbnVsbCAmJiBiaXRzKz0ieCIKICAgICAgICBlY2hvIC1uICIkc3RhdHVzIiAyPiAvZGV2L251bGwgfCBncmVwICJtb2RpZmllZDoiICY+IC9kZXYvbnVsbCAmJiBiaXRzKz0iISIKICAgICAgICBpZiBbWyAtbiAiJGJpdHMiIF1dOyB0aGVuCiAgICAgICAgICAgIHByb21wdCs9IiBcW1xlWzMybVxdZ2l0OihcW1xlWzMxbVxdJGJyYW5jaFxbXGVbMzJtXF0pXFtcZVszM21cXSRiaXRzXFtcZVswbVxdIgogICAgICAgIGVsc2UKICAgICAgICAgICAgcHJvbXB0Kz0iIFxbXGVbMzJtXF1naXQ6KFxbXGVbMzFtXF0kYnJhbmNoXFtcZVszMm1cXSlcW1xlWzBtXF0iCiAgICAgICAgZmkKICAgIGZpCn0KCmJ1aWxkX3Byb21wdCgpIHsKICAgIGV4aXRDb2RlPSIkPyIKICAgIHByb21wdF9leGl0Y29kZQogICAgcHJvbXB0Kz0iXFtcZVszNm1cXVxXIgogICAgcHJvbXB0X2dpdAogICAgcHJvbXB0X2V4aXRjb2RlCiAgICBwcm9tcHQrPSIg4p2vIgogICAgcHJvbXB0Kz0iXFtcZVswbVxdICIKICAgIFBTMT0iJHByb21wdCIKICAgIHByb21wdD0iIgp9CgpQUk9NUFRfQ09NTUFORD1idWlsZF9wcm9tcHQKCg==" | base64 -d >> ~/.bashrc
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Custom bash shell open new tab to see it";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
$SMK_SUDO usermod -s /bin/bash $(whoami)
;;
"Custom bind key and alias")
$SMK_SUDO apt install xclip -y
$SMK_SUDO apt install fzf -y 
if [[ $(echo $SHELL | grep  -oP "zsh") == "zsh" ]];then 
cp -f ~/.zshrc ~/.zshrc.smk
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Please don't delete ~/.zshrc.smk";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo "IyBDdXN0b20gQWxpYXNlcyBhbmQgS2V5YmluZGluZ3MgZnJvbSBTZXRNeUthbGkKYWxpYXMgYz0neGNsaXAnCmFsaWFzIHY9J3hjbGlwIC1vJwphbGlhcyBjdj0neGNsaXAgLXNlbGVjdGlvbiBjbGlwYm9hcmQnCmFsaWFzIG5tYXA9J2dyYyBubWFwJwphbGlhcyBwaW5nPSdncmMgcGluZycKYWxpYXMgdGFpbD0nZ3JjIHRhaWwnCmFsaWFzIHBzPSdncmMgcHMnCmFsaWFzIHRyYWNlcm91dGU9J2dyYyB0cmFjZXJvdXRlJwphbGlhcyBuZXRzdGF0PSdncmMgbmV0c3RhdCcKYWxpYXMgdGJ1ZmY9J3RtdXggc2F2ZS1idWZmZXIgLScKYmluZGtleSAtcyBcIl54XCIgJ3RidWZmIHwgY3ZeTScKYmluZGtleSAtcyBcIl5wXCIgXCJeZV51IHhzZWwgLWliIDw8XCJFT0ZcIlxuXnlcbkVPRlxuXnlcIgo=" |base64 -d >> ~/.zshrc
echo "source /usr/share/doc/fzf/examples/key-bindings.zsh" >> ~/.zshrc
elif [[ $(echo $SHELL | grep  -oP "bash") == "bash" ]];then 
cp -f ~/.bashrc ~/.bashrc.smk
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Please don't delete ~/.bashrc.smk";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo "IyBDdXN0b20gQWxpYXNlcyBhbmQgS2V5YmluZGluZ3MgZnJvbSBTZXRNeUthbGkKYWxpYXMgYz0neGNsaXAnCmFsaWFzIHY9J3hjbGlwIC1vJwphbGlhcyBjdj0neGNsaXAgLXNlbGVjdGlvbiBjbGlwYm9hcmQnCmFsaWFzIG5tYXA9J2dyYyBubWFwJwphbGlhcyBwaW5nPSdncmMgcGluZycKYWxpYXMgdGFpbD0nZ3JjIHRhaWwnCmFsaWFzIHBzPSdncmMgcHMnCmFsaWFzIHRyYWNlcm91dGU9J2dyYyB0cmFjZXJvdXRlJwphbGlhcyBuZXRzdGF0PSdncmMgbmV0c3RhdCcKYWxpYXMgdGJ1ZmY9J3RtdXggc2F2ZS1idWZmZXIgLScKYmluZCAnIlxDLXAiOiAiXEMtZVxDLXUgeHNlbCAtaWIgPDwiRU9GIlxuXEMteVxuRU9GXG5cQy15IicKYmluZCAteCAnIlxDLXgiOiAidGJ1ZmYgfCBjdiInCgo=" |base64 -d >> ~/.bashrc
echo "source /usr/share/doc/fzf/examples/key-bindings.bash" >> ~/.bashrc
fi
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Aliases and Bind Keys.";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33mAlias/BindKey ❯\033[0;0m] Usage.";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ c\033[0;0m] copy stdout in xclip";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ v\033[0;0m] paste stdout from xclip memory";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ cv\033[0;0m] copy stdout to clipboard";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ Ctrl+P\033[0;0m] copy current line on terminal to clipboard";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ Ctrl+x\033[0;0m] copy tmux buffer into clipboard";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ Ctrl+r\033[0;0m] fzf reverse search history";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
;;
"Wallpaper")
wget -q https://raw.githubusercontent.com/root-tanishq/setmykali/main/wallpaper/smk_default_wallpaper.jpg -O ~/Desktop/smk_default_wallpaper.jpg 
echo -e "[\033[0;32m❯\033[0;0m] Default wallpaper downloaded \033[0;33m~/Desktop/smk_default_wallpaper.jpg \033[0;0m"
;;
"Reset Setting")
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Reseting changes from backup files";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
if [[ -e ~/.zshrc_c.smk ]]; then 
cp ~/.zshrc_c.smk ~/.zshrc
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] ZSHRC File restored";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
else 
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;31m❯\033[0;0m] Failed to restore ZSHRC File";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
fi
if [[ -e ~/.bashrc_c.smk ]]; then 
cp ~/.bashrc_c.smk ~/.bashrc
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] BASHRC File restored";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
else 
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;31m❯\033[0;0m] Failed to restore BASHRC File";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
fi
if [[ -e ~/.vimrc.smk ]]; then 
cp ~/.vimrc.smk ~/.vimrc
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] VIMRC File restored";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
else 
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;31m❯\033[0;0m] Failed to restore VIMRC File";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
fi
if [[ -e ~/.tmux.conf.smk ]]; then 
cp ~/.tmux.conf.smk ~/.tmux.conf
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] TMUX CONFIG File restored";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
else 
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;31m❯\033[0;0m] Failed to restore TMUX CONFIG File";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
fi
;;
"help")
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] HELP for SetMyKali Customization Section";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33mCommand ❯\033[0;0m] Information";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ 1\033[0;0m] Customize vim with lightline";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ 2\033[0;0m] Customize tmux with tmux-themepack and custom settings";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ 3\033[0;0m] Customize zsh with ohmyzsh";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ 4\033[0;0m] Custom bash shell";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ 5\033[0;0m] Custom bind keys and aliases";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ 6\033[0;0m] SetMyKali Default Wallpaper";
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯ 7\033[0;0m] Reset settings if backup is not deleted";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
;;
"Goto Main Section")
PS3=$(echo -e "\n[\033[0;32m?❯\033[0;0m] SetMyKali Main Section\033[1;33m>\033[0;0m ")
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Exited to SetMyKali Main Section.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
break
;;
"Quit")
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Thankyou for using setmykali.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
;;
esac
done
}



#------------------------------------------------------------------------
# Application Downloading function
#------------------------------------------------------------------------
function smk_app_install () {
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Installing fzf dependency.";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
$SMK_SUDO apt install fzf -y 
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Select \033[1;33m'Install_all_apps'\033[0;0m option to install all softwares";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
sleep 1.5
# main loop start
while :
do
smk_apps_to_install="snap\ntelegram-desktop\nchromium\ncode-oss\npreload\nremmina\nstacer\nOBS-COMPLETE\npython3-pip\nseclists\ngobuster\ndirsearch\nInstall_all_apps\nGoto_Main_Section\nQuit"
smk_apps_to_install_fzf=$( printf $smk_apps_to_install | fzf )
if [[ $smk_apps_to_install_fzf == "snap" ]];then
#--------------------------------------------------------------SNAP-START
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Installing \033[1;33m'snap'\033[0;0m.";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
$SMK_SUDO apt install snapd -y
$SMK_SUDO systemctl enable --now snapd apparmor
$SMK_SUDO systemctl restart --now snapd apparmor
# snap while loop
while :
do
smk_snap_apps="signal-desktop\ndiscord\nspotify\nGo_to_application_section\nInstall_all_snaps\nQuit"
smk_snap_apps_fzf=$( printf $smk_snap_apps | fzf)
# snap loop
if [[ $smk_snap_apps_fzf == "Install_all_snaps" ]];then
for install_all_snaps in $( printf ${smk_snap_apps} );do
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Installing \033[1;33m'${install_all_snaps}'\033[0;0m.";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
$SMK_SUDO snap install ${install_all_snaps}
done
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Installation completed.";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
elif [[ $smk_snap_apps_fzf == "Go_to_application_section" ]];then
break
elif [[ $smk_snap_apps_fzf == "Quit" ]];then
exit
else 
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Installating \033[1;33m'$smk_snap_apps_fzf'\033[0;0m.";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
$SMK_SUDO snap install $smk_snap_apps_fzf
fi
# snap loop end
done
# snap while loop end
#--------------------------------------------------------------SNAP-END
elif [[ $smk_apps_to_install_fzf == "OBS-COMPLETE" ]];then
#--------------------------------------------------------------OBS-START
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Installating \033[1;33m'OBS-COMPLETE'\033[0;0m."
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Installating \033[1;33m'ffmpeg'\033[0;0m."
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
$SMK_SUDO apt install ffmpeg -y
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Installating \033[1;33m'obs-studio'\033[0;0m."
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
$SMK_SUDO apt install obs-studio -y
#--------------------------------------------------------------OBS-END
elif [[ $smk_apps_to_install_fzf == "Install_all_apps" ]];then
#--------------------------------------------------------------Installing-all-apps-start
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Mode \033[1;33m'Install all apps'\033[0;0m."
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
for install_all_apps in $(printf ${smk_apps_to_install});do 
  if [[ $install_all_apps == "OBS-COMPLETE" ]];then
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Installating \033[1;33m'ffmpeg and obs-studio'\033[0;0m."
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  $SMK_SUDO apt install ffmpeg -y
  $SMK_SUDO apt install obs-studio -y
  else 
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Installating \033[1;33m'${install_all_apps}'\033[0;0m."
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  $SMK_SUDO apt install ${install_all_apps} -y
  fi
done
#--------------------------------------------------------------Installing-all-apps-end
elif [[ $smk_apps_to_install_fzf == "Goto_Main_Section" ]];then
#--------------------------------------------------------------go-to-main-start
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Entering \033[1;33m'Main Section'\033[0;0m."
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
break
#--------------------------------------------------------------go-to-main-end
elif [[ $smk_apps_to_install_fzf == "Quit" ]];then
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Thankyou for using setmykali.";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
exit
else
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[1;32m❯\033[0;0m] Installating \033[1;33m'${smk_apps_to_install_fzf}'\033[0;0m."
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
$SMK_SUDO apt install ${smk_apps_to_install_fzf} -y
fi
done
# main loop end
}









#------------------------------------------------------------------------
# Main Section
#------------------------------------------------------------------------
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo -e "\033[0;36m|\033[0;0m[\033[0;32m??!❯\033[0;0m] Please choose one option";
echo -e "\033[0;36m|\033[0;0m[\033[0;32m??!❯\033[0;0m] Please enter the no. in front of desired option";
echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
echo
PS3=$(echo -e "\n[\033[0;32m?❯\033[0;0m] SetMyKali Main Section\033[1;33m>\033[0;0m ")
smk_main_options=("1st time setup" "Application Install" "Customization" "Upgrade Kali" "help" "Common Fixes" "Creator Information" "Exit Main Section" "Quit")
select smk_main_opt in "${smk_main_options[@]}"
do
case $smk_main_opt in
  "1st time setup")
  first_time_setup
  ;;
  "Application Install")
  smk_app_install
  ;;
  "Customization")
  smk_customization
  ;;
  "Upgrade Kali")
  smk_upgrade_kali
  ;;
  "help")
  smk_main_sec_help
  ;;
  "Creator Information")
  smk_creator_info
  ;;
  "Common Fixes")
  smk_common_fixes
  ;;
  "Exit Main Section")
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Exited SetMyKali Main Section.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Thankyou for using setmykali.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  break
  ;;
  "Quit")
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  echo -e "\033[0;36m|\033[0;0m[\033[1;33m❯\033[0;0m] Thankyou for using setmykali.";
  echo -e "\033[0;36m|-----------------------------------------------------------------\033[0;0m"
  exit
  ;;
  *) echo -e "[\033[0;31m!❯\033[0;0m] invalid option $REPLY";;
esac
done
#------------------------------------------------------------------------
# Script end
#------------------------------------------------------------------------