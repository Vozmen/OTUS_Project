#System updating
sudo apt update
sudo apt upgrade -y

curl -s -X POST https://api.telegram.org/bot5895911093:AAHGtzWM82We7wuhlpfN6KgTmKtFPMWJGWc/sendMessage -d chat_id=191948484 -d text="PROMETHEUS: SYSTEM UPDATED"
sleep 2

#preinstallation, system setting
sudo timedatectl set-timezone Europe/Moscow
#
sudo sh -c "echo 127.0.1.1 promet.netnoir.ru > /etc/hosts"
sudo sh -c "echo 172.20.0.50 promet >> /etc/hosts"

curl -s -X POST https://api.telegram.org/bot5895911093:AAHGtzWM82We7wuhlpfN6KgTmKtFPMWJGWc/sendMessage -d chat_id=191948484 -d text="PROMETHEUS: PREINSTALLATION COMPLETED"
sleep 2

#Prometheus installation
sudo mkdir -p /root/prometheus
sudo mkdir -p /etc/prometheus
sudo mkdir -p /var/lib/prometheus/
sudo wget https://github.com/prometheus/prometheus/releases/download/v2.40.0-rc.0/prometheus-2.40.0-rc.0.linux-amd64.tar.gz -O /root/prometheus/prometheus.tar.gz
sudo tar xfv /root/prometheus/prometheus.tar.gz -C /root/prometheus/
sudo rm /root/prometheus/prometheus.tar.gz
sudo mv /root/prometheus/prometheus-2.40.0-rc.0.linux-amd64/prometheus /usr/local/bin
sudo rm -R /root/prometheus/prometheus-2.40.0-rc.0.linux-amd64/
sudo wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/prometheus.service -O /etc/systemd/system/prometheus.service
sudo wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/prometheus -O /etc/prometheus/prometheus.yml
sudo useradd --no-create-home --shell /usr/sbin/nologin prometheus
sudo chown prometheus: /var/lib/prometheus/

curl -s -X POST https://api.telegram.org/bot5895911093:AAHGtzWM82We7wuhlpfN6KgTmKtFPMWJGWc/sendMessage -d chat_id=191948484 -d text="PROMETHEUS: PROMETHEUS INSTALLATION COMPLETED"
sleep 2

#Node_exporter installation
sudo wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0/node_exporter-1.4.0.linux-amd64.tar.gz -O /root/prometheus/node_exporter.tar.gz
sudo tar xfv /root/prometheus/node_exporter.tar.gz -C /root/prometheus/
sudo rm /root/prometheus/node_exporter.tar.gz
sudo mv /root/prometheus/node_exporter-1.4.0.linux-amd64/node_exporter /usr/local/bin
sudo rm -R /root/prometheus/node_exporter-1.4.0.linux-amd64/
sudo wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/node_exporter.service -O /etc/systemd/system/node_exporter.service
sudo useradd --no-create-home --shell /usr/sbin/nologin node_exporter
sudo chown node_exporter: /usr/local/bin/node_exporter
sudo systemctl daemon-reload
sudo systemctl enable --now prometheus.service
sudo systemctl enable --now node_exporter.service

curl -s -X POST https://api.telegram.org/bot5895911093:AAHGtzWM82We7wuhlpfN6KgTmKtFPMWJGWc/sendMessage -d chat_id=191948484 -d text="PROMETHEUS: NODE_EXPORTER INSTALLATION COMPLETED"
sleep 2

#Grafana installation
sudo apt install -y libfontconfig1
sudo wget https://cloud.netnoir.ru/index.php/s/MJK57AirfHqpTT7/download/grafana_9.2.6_amd64.deb -O /root/grafana_9.2.6_amd64.deb
sudo dpkg -i /root/grafana_9.2.6_amd64.deb
sudo systemctl enable --now grafana-server.service
sudo rm /var/lib/grafana/grafana.db -f
sudo wget https://cloud.netnoir.ru/index.php/s/Kk39dFk7rHA4Ci7/download/grafana.db -O /var/lib/grafana/grafana.db
sudo chown grafana: /var/lib/grafana/grafana.db
sudo systemctl restart grafana-server.service

curl -s -X POST https://api.telegram.org/bot5895911093:AAHGtzWM82We7wuhlpfN6KgTmKtFPMWJGWc/sendMessage -d chat_id=191948484 -d text="PROMETHEUS: GRAFANA INSTALLATION COMPLETED"
sleep 2
curl -s -X POST https://api.telegram.org/bot5895911093:AAHGtzWM82We7wuhlpfN6KgTmKtFPMWJGWc/sendMessage -d chat_id=191948484 -d text="PROMETHEUS: SYSTEM READY"
