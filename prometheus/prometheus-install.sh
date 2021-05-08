#!/bin/bash


PROM_VER="2.26.0"
SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`


# update system
sudo apt-get update
sudo apt-get upgrade -y


# create user
sudo useradd --no-create-home --shell /usr/sbin/nologin prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

# install prometheus
cd ${HOME}
wget https://github.com/prometheus/prometheus/releases/download/v${PROM_VER}/prometheus-${PROM_VER}.linux-amd64.tar.gz
tar xfz prometheus-*.tar.gz
cd ${HOME}/prometheus-${PROM_VER}.linux-amd64
sudo cp ./prometheus /usr/local/bin/
sudo cp ./promtool /usr/local/bin/
sudo cp -r ./consoles /etc/prometheus
sudo cp -r ./console_libraries /etc/prometheus
cd ${HOME} && rm -rf prometheus*

# create prometheus config
sudo cp ${SCRIPT_DIR}/prometheus.yml /etc/prometheus/prometheus.yml

# create prometheus servie
sudo cp ${SCRIPT_DIR}/prometheus.service /etc/systemd/system/prometheus.service

# fix permissions
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo chown -R prometheus:prometheus /etc/prometheus/  /var/lib/prometheus/
sudo chmod -R 775 /etc/prometheus/ /var/lib/prometheus/

# create aliases
echo "" >> ~/.bashrc
echo "# prometheus aliases" >> ~/.bashrc
echo "alias promstart='sudo systemctl start prometheus'" >> ~/.bashrc
echo "alias promstop='sudo systemctl stop prometheus'" >> ~/.bashrc
echo "alias promstatus='sudo systemctl status prometheus'" >> ~/.bashrc
echo "alias promlogs='journalctl -u prometheus.service -f'" >> ~/.bashrc
source  ~/.bashrc

# done
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl restart prometheus

echo "### done ###"
echo "# activate aliases:"
echo "source ~/.bashrc"
echo "# check prometheus status"
echo "promstatus"
