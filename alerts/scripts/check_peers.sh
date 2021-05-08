#!/bin/bash

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
NODE_NAME=Sora
MIN_PEERS=30

PEERS=`curl -s http://localhost:9090/api/v1/query?query=substrate_sync_peers | jq -r '.data.result[].value[1]'`

echo ""
echo "-------------------------"
echo `date`
echo "peers:" ${PEERS}

if [[ ${PEERS} -lt ${MIN_PEERS} ]]
  then
    echo "ALARM! ${NODE_NAME} node on ${HOSTNAME} is lost peers"
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "${HOSTNAME} inform you:" "ALARM! ${NODE_NAME} has ${PEERS} peers, lower than limit: ${MIN_PEERS}"  2>&1 > /dev/null
  else
    echo "peers are ok"
fi

