echo "Which version of Debian do you have?"
read debianversion

if [ "$debianversion" = "10" ]
then
	
if 10 then buster

echo "deb http://deb.debian.org/debian $debianversion-backports main" >>/etc/apt/sources.list
apt update
apt-get -t $debianversion-backports install wireguard

reboot

ip link add dev wg0 type wireguard
ip address add dev wg0 192.168.124.1/24


#Generate key

umask 077; wg genkey | tee privatekey | wgpubkey > publickey

varkeypriv="$(cat privatekey)"

varkeypriv="$(cat privatekey)"
unset varkeypriv

varkeypub="$(cat publickey)"
unset varkeypriv


sed -i "s|<Private Key>|$varkeypriv|g" /etc/wireguard/wg0.conf
sed -i "s|<Public Key>|$varkeypub|g" /etc/wireguard/wg0.conf


sed -i "s|<Private Key>|$varkeypriv|g" /etc/wireguard/wg0.conf


--
[Interface]
PrivateKey = <Private Key>
Address = <IP address>
ListenPort = 51820
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE;
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE; 
