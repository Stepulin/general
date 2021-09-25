#!/bin/bash
clear
echo "##################################################"
echo "###############      Firewall      ###############"
echo "##################################################"
PS3='Please enter your choice: '
optionsfirewall=("Print rules" "Download and apply" "Add rules for OpenVPN" "Exit")
select opt in "${optionsfirewall[@]}"
do
    case $opt in
        "Print rules")
            echo "printing fw rules"
            ;;
        "Download and apply")
            echo "downloading and applying"
            ;;
        "Add rules for OpenVPN")
            echo "adding rules for OpenVPN"
            ;;
        "Exit")
            echo "exiting"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
