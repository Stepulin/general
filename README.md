# general

`apt update && apt upgrade && apt autoremove`

`mkdir .ssh; nano .ssh/authorized_keys;`

```bash
apt install mc net-tools apt-transport-https aptitude wget ca-certificates curl git vlan htop ssh nano sudo dirmngr software-properties-common nfs-common cifs-utils samba-client
```

```bash
apt install bash-completion && . /etc/bash_completion && echo . /etc/bash_completion >> .bashrc
```

## firewall

```
wget https://raw.githubusercontent.com/Stepulin/general/master/firewall/firewall_apply.sh && wget https://raw.githubusercontent.com/Stepulin/general/master/firewall/firewall_rules.sh && bash firewall_apply.sh
```

## Package

```
wget https://raw.githubusercontent.com/Stepulin/general/master/package/package.sh && bash package.sh
```

## KB

fi terminates the preceding if, while ;; terminates the y) case in the case...esac.

#### Windows Server HDD usage in Task Manager
diskperf -y

#### CentOS change IP
nmtui
