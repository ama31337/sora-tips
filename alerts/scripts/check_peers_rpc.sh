#!/bin/bash

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
NODE_NAME=Sora
LOCAL_RPC="http://127.0.0.1:9933"
MIN_PEERS=30

PEERS=$(curl -sH "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "system_peers"}' ${LOCAL_RPC}  | jq  -r '.result' | jq length)

echo ""
echo "-------------------------"
echo `date`
echo "peers num:" ${PEERS}

if [[ ${PEERS} -lt ${MIN_PEERS} ]]
  then
    echo "ALARM! ${NODE_NAME} node on ${HOSTNAME} is lost peers"
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "${HOSTNAME} inform you:" "ALARM! ${NODE_NAME} has ${PEERS} peers, lower than limit: ${MIN_PEERS}"  2>&1 > /dev/null
  else
    echo "peers are ok"
fi
