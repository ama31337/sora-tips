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
vim ${HOME}/sora2/docker-compose.yml
```
or
```sh
nano ${HOME}/sora2/docker-compose.yml
```
5. Create aliases
```sh
echo "" >> ~/.bashrc
echo "# sora aliases" >> ~/.bashrc
echo "alias sorastart='cd ${HOME}/sora2; docker-compose up -d'" >> ~/.bashrc
echo "alias sorastop='cd ${HOME}/sora2; docker-compose down'" >> ~/.bashrc
echo "alias soralogs='docker logs -f sora-mainnet'" >> ~/.bashrc
source  ~/.bashrc
``` 

6. Start node
```sh
sorastart
```
 Check logs
```sh
soralogs
```
 Stop node
```sh
sorastop
```

You can check your node sync status on:
https://telemetry.polkadot.io/#/SORA

And interact with the network via our RPC on:
https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Fsora.lux8.net#/staking

To rotate node keys, run
```sh
docker exec $(docker ps | grep sora2/substrate |  awk '{print $1;}') curl -s http://localhost:9933 -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "author_rotateKeys", "params”:[]}’
```

###
If you find this helpful, stake with us: https://lux8.net/sora
