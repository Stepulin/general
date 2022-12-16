COPIED from DP

### příkaz
# otevři soubor a vlož do něj příkaz, který bude spouštět kód
nano laborator.sh
# překopíruj soubor do adresáře /usb/bin/
cp laborator.sh /usr/bin/
# učiň soubor spustitelným
chmod +x /usr/bin/laborator.sh

### služba
# otevři soubor a vlož do něj text charakteristický pro službu,
# která bude spouštět (volat) výše vytvořený soubor
nano laborator.service
# zkopíruj ho do adresáře /etc/systemd/system/
cp laborator.service /etc/systemd/system/
# nastav pravidla pro čtení
chmod 644 /etc/systemd/system/laborator.service
# zapni start služby po (re)startu stroje
systemctl enable laborator.service
# spušť službu
systemctl start laborator.service
# ověř, zda služba naběhla
systemctl status laborator.service 

root@hypervspssdeb:~# cat laborator.sh
jupyter-lab --allow-root 

root@hypervspssdeb:~# cat laborator.service
[Unit]
Description=Spousteni Jupyteru pri startu stroje
[Service]
Type=simple
ExecStart=/bin/bash /usr/bin/laborator.sh
[Install]
WantedBy=multi-user.target 
