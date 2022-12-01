#System updating
yum update -y
yum upgrade -y

curl -s -X POST https://api.telegram.org/bot5821181278:AAHVF4q5b9EuqA7pLbmC7XnC-1PNc_kGFm4/sendMessage -d chat_id=191948484 -d text="ELK: SYSTEM UPDATED"
sleep 2

#Preinstallation, system setting 
hostnamectl set-hostname elk.netnoir.ru
#
sudo sh -c "echo 127.0.1.1 elk.netnoir.ru > /etc/hosts"
sudo sh -c "echo 172.20.0.52 elk >> /etc/hosts"

curl -s -X POST https://api.telegram.org/bot5821181278:AAHVF4q5b9EuqA7pLbmC7XnC-1PNc_kGFm4/sendMessage -d chat_id=191948484 -d text="ELK: PREINSTALLATION COMPLETED"
sleep 2

#Elasticsearch installation
mkdir /root/RPMs
wget https://cloud.netnoir.ru/index.php/s/qY2SYs6SKSoLJ6X/download/elasticsearch_7.17.3_x86_64-224190-9bcb26.rpm -O /root/RPMs/elasticsearch.rpm --no-check-certificate
rpm -i /root/RPMs/elasticsearch.rpm
echo -Xms2g > /etc/elasticsearch/jvm.options.d/jvm.options
echo -Xms2g >> /etc/elasticsearch/jvm.options.d/jvm.options
systemctl enable --now elasticsearch

curl -s -X POST https://api.telegram.org/bot5821181278:AAHVF4q5b9EuqA7pLbmC7XnC-1PNc_kGFm4/sendMessage -d chat_id=191948484 -d text="ELK: ELASTICSEARCH INSTALLATION COMPLETED"
sleep 2

#Kibana installation
wget https://cloud.netnoir.ru/index.php/s/mKtK6sq999Q8dak/download/kibana_7.17.3_x86_64-224190-b13e53.rpm -O /root/RPMs/kibana.rpm --no-check-certificate
rpm -i /root/RPMs/kibana.rpm
rm /etc/kibana/kibana.yml -f
wget https://cloud.netnoir.ru/index.php/s/PorTKrtyC4ocTFA/download/kibana.yml -O /etc/kibana/kibana.yml --no-check-certificate
systemctl enable --now kibana

curl -s -X POST https://api.telegram.org/bot5821181278:AAHVF4q5b9EuqA7pLbmC7XnC-1PNc_kGFm4/sendMessage -d chat_id=191948484 -d text="ELK: KIBANA INSTALLATION COMPLETED"
sleep 2

#Logstash installation
wget https://cloud.netnoir.ru/index.php/s/nwcdBJ3N7BkW7Lr/download/logstash_7.17.3_x86_64-224190-3a605f.rpm -O /root/RPMs/logstash.rpm --no-check-certificate
rpm -i /root/RPMs/logstash.rpm
rm /etc/logstash/logstash.yml -f
wget https://cloud.netnoir.ru/index.php/s/tarb88YsZrFFWDT/download/logstash.yml -O /etc/logstash/logstash.yml --no-check-certificate
wget https://cloud.netnoir.ru/index.php/s/pex86yitMq8KyE8/download/nginx.conf -O /etc/logstash/conf.d/nginx.conf --no-check-certificate
systemctl enable --now logstash
#
until [[ "$fin" == "5400" ]]
fin=$(netstat -tulpn | grep -oE 5400)
do
  sleep 1
done

curl -s -X POST https://api.telegram.org/bot5821181278:AAHVF4q5b9EuqA7pLbmC7XnC-1PNc_kGFm4/sendMessage -d chat_id=191948484 -d text="ELK: LOGSTASH INSTALLATION COMPLETED"
sleep 2
curl -s -X POST https://api.telegram.org/bot5821181278:AAHVF4q5b9EuqA7pLbmC7XnC-1PNc_kGFm4/sendMessage -d chat_id=191948484 -d text="ELK: SYSTEM READY"
#/usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/nginx.conf
