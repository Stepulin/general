#!/bin/bash
# Preparing massive package; however, still in progress
clear
echo "##################################################"
echo "###############    script//menu    ###############"
echo "##################################################"
PS3='Please enter your choice: '
options=("Exit" "Clear" "Update" "Firewall" "Clean Up" "OpenVPN server")
select opt in "${options[@]}"
do
    case $opt in
        "Exit")
            break
            ;;
        "Clear")
            clear
            ;;
        "Update")
            wget https://raw.githubusercontent.com/Stepulin/general/master/update.sh && bash update.sh
            ;;
        "Firewall")
            wget https://raw.githubusercontent.com/Stepulin/general/master/firewall/firewall.sh && bash firewall.sh
            ;;
        "Clean Up")
            echo "Deleting everything in this folder"
            rm *
            echo "Done"
            ;;
        "OpenVPN server")
            wget https://raw.githubusercontent.com/Stepulin/general/master/package/openvpn/server_setup.sh && bash server_setup.sh
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
