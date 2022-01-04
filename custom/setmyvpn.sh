#!/bin/bash
echo -e "\033[0;33m####################"
echo -e "#     SetMyVpn     #"
echo -e "####################\e[0m"
echo -e "\033[0;35m[\033[0;36m★\033[0;35m]-[A Sub Tool of Project SetMyKali]"
echo -e "[\033[0;36m★\033[0;35m]-[Created with <3 by BoyFromFuture]\033[0;32m"
cd /etc/openvpn
case $1 in
  set)
    select options in $(ls *.conf | cut -d "." -f 1);do
      sudo systemctl start openvpn@${options};
      echo "VPN Connected to ${options}";
      exit;
    done
    ;;
  create)
    echo "Please Provide the Name of the VPN:- ";
    read vpname
    echo -e "\033[0;32m----------------------------------";
    echo -e "\033[0;36mPlease paste the content of VPN in";
    echo -e "\033[0;32m----------------------------------";
    echo -e "\033[0;36mPlease Choose your text editor:-  ";
    echo -e "\033[0;32m----------------------------------";
    select ename in $(printf "nano\nvim");do
    sudo $ename /etc/openvpn/${vpname}.conf;
    exit;
    done
    ;;
  edit)
    select edit in $(ls *.conf | cut -d "." -f 1);do
      echo -e "\033[0;32m----------------------------------";
      echo -e "\033[0;36mPlease paste the content of VPN in";
      echo -e "\033[0;32m----------------------------------";
      echo -e "\033[0;36mPlease Choose your text editor:-  ";
      echo -e "\033[0;32m----------------------------------";
      select editor in $(printf "nano\nvim");do
      sudo $editor /etc/openvpn/${edit}.conf;
      exit;
      done
      done
   ;;
  del)
    select del in $(ls *.conf | cut -d "." -f 1);do
      sudo rm -f /etc/openvpn/${del}.conf;
      echo "${del} VPN File Deleted";
      exit;
    done
    ;;
  stop)
    sudo systemctl stop openvpn
    echo -e "\033[0;32mVPN Disconncted"; 
    ;;
  *)
    echo "Please use any of the options"
    echo -e "\033[0;32m------------------------------------------------------------------";
    echo -e "\033[0;32m|\033[0;34msetmyvpn set\033[0;32m            |\033[0;34mTo Connect to a vpn\033[0;32m                    |";
    echo -e "\033[0;32m|\033[0;34msetmyvpn create\033[0;32m         |\033[0;34mTo Create a new VPN File\033[0;32m               |"; 
    echo -e "\033[0;32m|\033[0;34msetmyvpn edit\033[0;32m           |\033[0;34mTo Edit the already existing VPN File\033[0;32m  |";
    echo -e "\033[0;32m|\033[0;34msetmyvpn del\033[0;32m            |\033[0;34mTo delete the already existing VPN File\033[0;32m|";
    echo -e "\033[0;32m|\033[0;34msetmyvpn stop\033[0;32m           |\033[0;34mDisconnect VPN                         \033[0;32m|";
    echo -e "\033[0;32m------------------------------------------------------------------";
    ;;
esac
