#!/bin/python3
import os
class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
print(f'''{bcolors.OKGREEN}

░██████╗███████╗░█████╗░██████╗░███████╗██████╗░
██╔════╝██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
╚█████╗░█████╗░░██║░░╚═╝██║░░██║█████╗░░██████╦╝
░╚═══██╗██╔══╝░░██║░░██╗██║░░██║██╔══╝░░██╔══██╗
██████╔╝███████╗╚█████╔╝██████╔╝███████╗██████╦╝
╚═════╝░╚══════╝░╚════╝░╚═════╝░╚══════╝╚═════╝░
{bcolors.ENDC}''')
os.system('sudo apt install apt-transport-https')
while True:
    print(f"{bcolors.WARNING}1> default kali repository")
    print(f"2> Fast russian repository{bcolors.ENDC}")
    var1 = int(input("Please Enter[1 or 2]:- "))
    if var1 == 1:
        os.system('deb [trusted=true] https://http.kali.org/kali kali-rolling main contrib non-free')
        break
    elif var1 == 2:
        os.system('deb [trusted=yes] https://mirror-1.truenetwork.ru/kali kali-rolling main contrib non-free')
        break
    else:
        print(f'{bcolors.FAIL}Please enter from any two options{bcolors.ENDC}')