#System updating
sudo apt update
sudo apt upgrade -y

curl -s -X POST https://api.telegram.org/bot5961686797:AAE2jtmp54yatQTVZMJwUzpx2TJZ2B5LHmo/sendMessage -d chat_id=191948484 -d text="CLOUD2: SYSTEM UPDATED"
sleep 2

#preinstallation, system setting
sudo timedatectl set-timezone Europe/Moscow
sudo apt install -y sudo apt install php php-apcu php-bcmath php-cli php-common php-curl php-gd php-gmp php-imagick php-intl php-mbstring php-mysql php-zip php-xml unzip cifs-utils nfs-common mysql-server
sudo wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/site2 -O /var/www/html/index.php
sudo systemctl restart apache2.service
sudo hostnamectl set-hostname cloud2.netnoir.ru
sudo mkdir /nextcloud
sudo sh -c "echo 127.0.1.1 cloud2.netnoir.ru > /etc/hosts"
sudo sh -c "echo 172.20.0.53 cloud2 >> /etc/hosts"
sudo sh -c "echo 172.20.0.2 HSERVER >> /etc/hosts"

sudo sh -c "echo //HSERVER/ncdata  /nextcloud cifs    username=otus,password=qwe123,uid=33,gid=33,iocharset=utf8,nofail,_netdev,noperm,mfsymlinks   0 0 >> /etc/fstab"
sudo mount -a

sudo wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/master2.conf -O /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql.service
sudo mysql -uroot -pqwe123 -Bse "CREATE USER 'repl'@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'qwe123'; GRANT ALL PRIVILEGES on *.* TO 'repl'@'%'; ALTER USER 'repl'@'%' IDENTIFIED WITH mysql_native_password BY 'qwe123'; FLUSH PRIVILEGES"

curl -s -X POST https://api.telegram.org/bot5961686797:AAE2jtmp54yatQTVZMJwUzpx2TJZ2B5LHmo/sendMessage -d chat_id=191948484 -d text="CLOUD2: PREINSTALLATION COMPLETE"
sleep 2

#prometheus/node_extractor installing
sudo mkdir /root/prometheus
sudo wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0/node_exporter-1.4.0.linux-amd64.tar.gz -O /root/prometheus/node_exporter.tar.gz
sudo tar xfv /root/prometheus/node_exporter.tar.gz -C /root/prometheus/
sudo mv /root/prometheus/node_exporter-1.4.0.linux-amd64/node_exporter /usr/local/bin
sudo rm -R /root/prometheus
sudo wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/node_exporter.service -O /etc/systemd/system/node_exporter.service
sudo useradd --no-create-home --shell /usr/sbin/nologin node_exporter
sudo chown node_exporter: /usr/local/bin/node_exporter
sudo systemctl daemon-reload
sudo systemctl enable --now node_exporter.service

curl -s -X POST https://api.telegram.org/bot5961686797:AAE2jtmp54yatQTVZMJwUzpx2TJZ2B5LHmo/sendMessage -d chat_id=191948484 -d text="CLOUD2: NODE_EXTRACTOR INSTALLATION COMPLETE"
sleep 2
curl -s -X POST https://api.telegram.org/bot5961686797:AAE2jtmp54yatQTVZMJwUzpx2TJZ2B5LHmo/sendMessage -d chat_id=191948484 -d text="CLOUD2: SYSTEM READY"

