rm /etc/ssh/ssh_host_*

/usr/sbin/dpkg-reconfigure openssh-server

ssh-keygen -t dsa -N "" -f /etc/ssh/ssh*host*dsa*key
ssh-keygen -t rsa -N "" -f /etc/ssh/ssh*host*rsa*key
ssh-keygen -t ecdsa -N "" -f /etc/ssh/ssh*host*ecdsa_key

Source: https://www.digitalocean.com/blog/avoid-duplicate-ssh-host-keys/
