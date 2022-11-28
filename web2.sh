#preinstallation, system setting
sudo wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/site2 -O /var/www/html/index.php
sudo sh -c "echo \<VirtualHost \*:80\>  > /etc/apache2/sites-enabled/000-default.conf"
sudo sh -c "echo ServerAdmin webmaster@localhost >> /etc/apache2/sites-enabled/000-default.conf"
sudo sh -c "echo DocumentRoot /var/www/html/index.php >> /etc/apache2/sites-enabled/000-default.conf"
sudo sh -c "echo ErrorLog \${APACHE_LOG_DIR}/error.log >> /etc/apache2/sites-enabled/000-default.conf"
sudo sh -c "echo CustomLog \${APACHE_LOG_DIR}/access.log combined >> /etc/apache2/sites-enabled/000-default.conf"
sudo sh -c "echo \<\/VirtualHost\> >> /etc/apache2/sites-enabled/000-default.conf"
sudo systemctl restart apache2.service
sudo hostnamectl set-hostname web2.netnoir.ru
sudo sh -c "echo 127.0.1.1 web2.netnoir.ru > /etc/hosts"
sudo sh -c "echo 172.20.0.53 web2 >> /etc/hosts"
sudo sh -c "echo 172.20.0.2 HSERVER >> /etc/hosts"

sudo wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/master2.conf -O /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql.service
sudo mysql -uroot -pqwe123 -Bse "CREATE USER 'repl'@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'qwe123'; GRANT ALL PRIVILEGES on *.* TO 'repl'@'%'; ALTER USER 'repl'@'%' IDENTIFIED WITH mysql_native_password BY 'qwe123'; FLUSH PRIVILEGES"

curl -s -X POST https://api.telegram.org/bot5961686797:AAE2jtmp54yatQTVZMJwUzpx2TJZ2B5LHmo/sendMessage -d chat_id=191948484 -d text="WEB2: PREINSTALLATION COMPLETE"
sleep 2
curl -s -X POST https://api.telegram.org/bot5961686797:AAE2jtmp54yatQTVZMJwUzpx2TJZ2B5LHmo/sendMessage -d chat_id=191948484 -d text="WEB2: SYSTEM READY"
