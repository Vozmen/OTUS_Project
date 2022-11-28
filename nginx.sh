#Preinstallation, system setting 
sudo sh -c "echo 127.0.1.1 nginx.netnoir.ru > /etc/hosts"
sudo sh -c "echo 172.20.0.48 nginx >> /etc/hosts"
#
yum install epel-release -y
yum install nginx -y
yum install wget -y
#
systemctl disable --now firewalld

curl -s -X POST https://api.telegram.org/bot5920470511:AAHk7V77EaXhL64-0e7gpAqOWgcNOiHDmoQ/sendMessage -d chat_id=191948484 -d text="BALANCER: PREINSTALLATION COMPLETED"
sleep 2

#Filebeat installation
mkdir /root/RPMs
wget https://cloud.netnoir.ru/index.php/s/WTZwZZHiirZQoic/download/filebeat_7.17.3_x86_64-224190-4c3205.rpm -O /root/RPMs/filebeat_7.17.3_x86_64-224190-4c3205.rpm --no-check-certificate
rpm -i /root/RPMs/*.rpm
wget https://cloud.netnoir.ru/index.php/s/QKca4tmJ5SEBX9k/download/filebeat.yml -O /etc/filebeat/filebeat.yml --no-check-certificate

curl -s -X POST https://api.telegram.org/bot5920470511:AAHk7V77EaXhL64-0e7gpAqOWgcNOiHDmoQ/sendMessage -d chat_id=191948484 -d text="BALANCER: FILEBEAT INSTALLATION COMPLETED"
sleep 2

#Nginx setting
rm /etc/nginx/sites-available/default -f
wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/default -O /etc/nginx/nginx.conf
systemctl restart nginx.service

curl -s -X POST https://api.telegram.org/bot5920470511:AAHk7V77EaXhL64-0e7gpAqOWgcNOiHDmoQ/sendMessage -d chat_id=191948484 -d text="BALANCER: BALANCER CONFIGURED"
sleep 2

#Services activated
systemctl enable --now nginx
systemctl enable --now filebeat
curl localhost

curl -s -X POST https://api.telegram.org/bot5920470511:AAHk7V77EaXhL64-0e7gpAqOWgcNOiHDmoQ/sendMessage -d chat_id=191948484 -d text="BALANCER: SERVICES ACTIVATED"
sleep 2
curl -s -X POST https://api.telegram.org/bot5920470511:AAHk7V77EaXhL64-0e7gpAqOWgcNOiHDmoQ/sendMessage -d chat_id=191948484 -d text="BALANCER: SYSTEM READY"
