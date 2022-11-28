#preinstallation, system setting
sudo mkdir /data
sudo sh -c "echo //HSERVER/data  /data cifs    username=otus,password=qwe123,uid=33,gid=33,iocharset=utf8,nofail,_netdev,noperm,mfsymlinks   0 0 >> /etc/fstab"
sudo mount -a
sudo wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/site1 -O /var/www/html/index.php
sudo sh -c "echo \<VirtualHost \*:80\>  > /etc/apache2/sites-enabled/000-default.conf"
sudo sh -c "echo ServerAdmin webmaster@localhost >> /etc/apache2/sites-enabled/000-default.conf"
sudo sh -c "echo DocumentRoot /var/www/html/index.php >> /etc/apache2/sites-enabled/000-default.conf"
sudo sh -c "echo ErrorLog \${APACHE_LOG_DIR}/error.log >> /etc/apache2/sites-enabled/000-default.conf"
sudo sh -c "echo CustomLog \${APACHE_LOG_DIR}/access.log combined >> /etc/apache2/sites-enabled/000-default.conf"
sudo sh -c "echo \<\/VirtualHost\> >> /etc/apache2/sites-enabled/000-default.conf"
sudo systemctl restart apache2.service
sudo hostnamectl set-hostname web1.netnoir.ru
sudo sh -c "echo 127.0.1.1 web1.netnoir.ru > /etc/hosts"
sudo sh -c "echo 172.20.0.52 web1 >> /etc/hosts"
sudo sh -c "echo 172.20.0.2 HSERVER >> /etc/hosts"

sudo wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/master1.conf -O /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql.service
sudo mysql -uroot -pqwe123 -Bse "CREATE USER 'repl'@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'qwe123'; GRANT ALL PRIVILEGES on *.* TO 'repl'@'%'; ALTER USER 'repl'@'%' IDENTIFIED WITH mysql_native_password BY 'qwe123'; FLUSH PRIVILEGES"

curl -s -X POST https://api.telegram.org/bot5959730095:AAE-oUFfnSh_vkP8jlieBJAj9KpE-WXK0Yc/sendMessage -d chat_id=191948484 -d text="WEB1: PREINSTALLATION COMPLETED"
sleep 2

#mysql-server setting (sync)
sudo mysql -uroot -pqwe123 -Bse "STOP SLAVE"
sudo mysql -h 172.20.0.53 -urepl -pqwe123 -Bse "FLUSH TABLES WITH READ LOCK"
binlog1=$(mysql -h 172.20.0.53 -urepl -pqwe123 -Bse "SHOW MASTER STATUS" | cut -f 1)
position1=$(mysql -h 172.20.0.53 -urepl -pqwe123 -Bse "SHOW MASTER STATUS" | cut -f 2)
sudo mysql -uroot -pqwe123 -Bse "CHANGE MASTER TO MASTER_HOST='172.20.0.53', MASTER_USER='repl', MASTER_PASSWORD='qwe123', MASTER_LOG_FILE='$binlog1', MASTER_LOG_POS=$position1; START SLAVE"
sudo mysql -h 172.20.0.53 -urepl -pqwe123 -Bse "UNLOCK TABLES"

sudo mysql -h 172.20.0.53 -urepl -pqwe123 -Bse "STOP SLAVE"
sudo mysql -uroot -pqwe123 -Bse "FLUSH TABLES WITH READ LOCK"
binlog2=$(sudo mysql -uroot -pqwe123 -Bse "SHOW MASTER STATUS" | cut -f 1)
position2=$(sudo mysql -uroot -pqwe123 -Bse "SHOW MASTER STATUS" | cut -f 2)
sudo mysql -h 172.20.0.53 -urepl -pqwe123 -Bse "CHANGE MASTER TO MASTER_HOST='172.20.0.52', MASTER_USER='repl', MASTER_PASSWORD='qwe123', MASTER_LOG_FILE='$binlog2', MASTER_LOG_POS=$position2; START SLAVE"
sudo mysql -uroot -pqwe123 -Bse "UNLOCK TABLES"

sudo mysql -uroot -pqwe123 -Bse "create database testdb"
table="/data/testdb/tables_list"
for var in $(cat $table)
do
sudo mysql -uroot -pqwe123 testdb < /data/testdb/$var.sql
done

curl -s -X POST https://api.telegram.org/bot5959730095:AAE-oUFfnSh_vkP8jlieBJAj9KpE-WXK0Yc/sendMessage -d chat_id=191948484 -d text="WEB1: SQL-SERVER SYNCHRONIZATION COMPLETED"
sleep 2
curl -s -X POST https://api.telegram.org/bot5959730095:AAE-oUFfnSh_vkP8jlieBJAj9KpE-WXK0Yc/sendMessage -d chat_id=191948484 -d text="WEB1: SYSTEM READY"
