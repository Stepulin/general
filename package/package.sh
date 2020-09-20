# Preparing massive package; however, still in progress

PS3='Please enter your choice: '
options=("Option 1" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "U P D A T E")
            wget https://raw.githubusercontent.com/Stepulin/general/master/package/update.sh && bash update.sh
            ;;
        " F I R E W A L L")
            rm firewall* && wget https://raw.githubusercontent.com/Stepulin/general/master/firewall/firewall_apply.sh && wget https://raw.githubusercontent.com/Stepulin/general/master/firewall/firewall_rules.sh && bash firewall_apply.sh
            ;;
        " - - - -")
            echo "Nothing in there yet"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
