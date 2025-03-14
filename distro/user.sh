#!/bin/bash

R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
W="$(printf '\033[1;37m')"
C="$(printf '\033[1;36m')"

banner() {
    clear
    printf "\033[33m    ▖ ▗▖▗▄▄▖ ▗▖ ▗▖▗▖  ▗▖▗▄▄▄▖▗▖ ▗▖    ▗▖  ▗▖ ▗▄▖ ▗▖  ▗▖\033[0m\n"
    printf "\033[36m    ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▐▛▚▖▐▌  █  ▐▌ ▐▌    ▐▛▚▞▜▌▐▌ ▐▌ ▝▚▞▘ \033[0m\n"
    printf "\033[32m    ▐▌ ▐▌▐▛▀▚▖▐▌ ▐▌▐▌ ▝▜▌  █  ▐▌ ▐▌    ▐▌  ▐▌▐▛▀▜▌  ▐▌  \033[0m\n"
    printf "\033[32m    ▝▚▄▞▘▐▙▄▞▘▝▚▄▞▘▐▌  ▐▌  █  ▝▚▄▞▘    ▐▌  ▐▌▐▌ ▐▌▗▞▘▝▚ \033[0m\n"
    printf "\033[0m\n"
    printf "     \033[32m Any Error Contact\033[0m\n"
    printf "\033[0m\n"

}

sudo() {
    echo -e "\n${R} [${W}-${R}]${C} Installing Sudo..."${W}
    apt update -y
    apt install sudo -y
    apt install wget apt-utils locales-all dialog tzdata -y
    echo -e "\n${R} [${W}-${R}]${G} Sudo Successfully Installed !"${W}

}

login() {
    banner
    read -p $' \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Input Username [Lowercase] : \e[0m\e[1;96m\en' user
    echo -e "${W}"
    read -p $' \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Input Password : \e[0m\e[1;96m\en' pass
    echo -e "${W}"
    useradd -m -s $(which bash) ${user}
    usermod -aG sudo ${user}
    echo "${user}:${pass}" | chpasswd
    echo "$user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
    echo "proot-distro login --user $user ubuntu --bind /dev/null:/proc/sys/kernel/cap_last_last --shared-tmp --fix-low-ports" > /data/data/com.termux/files/usr/bin/ubuntu
    #chmod +x /data/data/com.termux/files/usr/bin/ubuntu 
    
    if [[ -e '/data/data/com.termux/files/home/MAX-UBUNTU/distro/gui.sh' ]];then
        cp /data/data/com.termux/files/home/MAX-UBUNTU/distro/gui.sh /home/$user/gui.sh
        chmod +x /home/$user/gui.sh
    else
        wget -q --show-progress https://raw.githubusercontent.com/akash-max4x-account/MAX-UBUNTU/master/distro/gui.sh
        mv -vf gui.sh /home/$user/gui.sh
        chmod +x /home/$user/gui.sh
    fi

    clear
    echo
    echo -e "\n${R} [${W}-${R}]${G} Restart your Termux & Type ${C}ubuntu"${W}
    echo -e "\n${R} [${W}-${R}]${G} Then Type ${C}sudo bash gui.sh "${W}
    echo

}

banner
sudo
login
