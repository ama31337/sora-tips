### The easiest way to run you SORA mainnet node

### Installation
1. Install docker 
```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ${USER}
newgrp docker
sudo service docker restart
```
and docker-compose
```sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

2. Clone this repository to your server
```sh
cd $HOME; git clone https://github.com/ama31337/sora-tips.git
```
3. Create Sora working dir and copy docker-compose
```sh
mkdir -p ${HOME}/sora2/chain
sudo chown 10000:10000 ${HOME}/sora2/chain
cp ${HOME}/sora-tips/docker-compose.yml ${HOME}/sora2
```
4. Edit your node name in docker-compose with your preffered text editor
```sh
vim ${HOME}/sora-tips/docker-compose.yml
```
or
```sh
nano ${HOME}/sora-tips/docker-compose.yml
```
5. Start node
```sh
docker-compose up -d
```
6. Check logs
```sh
docker logs -f sora-mainnet
```
