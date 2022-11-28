#System updating
yum update -y
yum upgrade -y
curl -s -X POST https://api.telegram.org/bot5920470511:AAHk7V77EaXhL64-0e7gpAqOWgcNOiHDmoQ/sendMessage -d chat_id=191948484 -d text="BALANCER: SYSTEM UPDATED"
sleep 2

#Preinstallation, system setting 
sudo sh -c "echo 127.0.1.1 nginx.netnoir.ru > /etc/hosts"
sudo sh -c "echo 172.20.0.48 nginx >> /etc/hosts"
#
yum install epel-release -y
mkdir /root/RPMs
wget https://nginx.org/packages/mainline/centos/7/x86_64/RPMS/nginx-1.9.9-1.el7.ngx.x86_64.rpm -O /root/RPMs/nginx-1.9.9-1.el7.ngx.x86_64.rpm
rpm -i /root/RPMs/nginx-1.9.9-1.el7.ngx.x86_64.rpm
#
systemctl disable --now firewalld

curl -s -X POST https://api.telegram.org/bot5920470511:AAHk7V77EaXhL64-0e7gpAqOWgcNOiHDmoQ/sendMessage -d chat_id=191948484 -d text="BALANCER: PREINSTALLATION COMPLETED"
sleep 2

#Filebeat installation
wget https://cloud.netnoir.ru/index.php/s/WTZwZZHiirZQoic/download/filebeat_7.17.3_x86_64-224190-4c3205.rpm -O /root/RPMs/filebeat_7.17.3_x86_64-224190-4c3205.rpm --no-check-certificate
rpm -i /root/RPMs/filebeat_7.17.3_x86_64-224190-4c3205.rpm
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
