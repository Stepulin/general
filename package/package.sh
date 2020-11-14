#!/bin/bash
# Preparing massive package; however, still in progress
clear

echo "##################################################"
echo "###############    script//menu    ###############"
echo "##################################################"

PS3='Please enter your choice: '
options=("Update" "Firewall" "Clean Up" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Update")
            wget https://raw.githubusercontent.com/Stepulin/general/master/package/update.sh && bash update.sh
            ;;
        "Firewall")
            echo "you chose choice 2"
            ;;
        "Clean Up")
            echo "Deleting everything in this folder"
            rm *
            echo "Done"
            ;;
        "Exit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
