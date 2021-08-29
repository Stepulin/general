# general

```bash
apt update && apt upgrade && apt autoremove
```

```bash
apt update && apt upgrade -y && apt autoremove -y
```
------
UPGRADE

```bash
apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y
```

```bash
apt-get autoremove && apt-get clean
```

```bash
mv /etc/apt/source.list /etc/apt/source.list.old && nano /etc/apt/source.list
```

```bash
apt-get update -y && apt-get full-upgrade -y
```

------

```bash
mkdir .ssh; nano .ssh/authorized_keys;
```

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
wget https://raw.githubusercontent.com/Stepulin/general/master/menu.sh && bash menu.sh
```

OR

```
wget https://raw.githubusercontent.com/Stepulin/general/master/menu.sh && chmod +x menu.sh && ./menu.sh
```

## KB

fi terminates the preceding if, while ;; terminates the y) case in the case...esac.

#### Windows Server HDD usage in Task Manager
diskperf -y

#### CentOS change IP
nmtui

***

#### GRAV

**FIRST** put your **grav.conf** and **ca.crt** **yourdomain.crt** and **yourdomain.key** into **root** folder upfront

Otherwise, you will have to edit /etc/apache2/sites-available/grav.conf manualy and you may experience other issues.

```bash
wget https://raw.githubusercontent.com/Stepulin/general/master/package/grav/grav_install.sh && bash grav_install.sh
```

Go to https://yourdomain.com, do the setup and then reboot to reload your full iptable.
