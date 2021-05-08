#!/bin/bash

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
NODE_NAME=Sora
RPC_SERVER="http://sora.rpc.lux8.net/"
LOCAL_RPC="http://127.0.0.1:9933"
BLOCK_DIFF=10


RPC_HEX_BLOCK=$(curl -sH "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "chain_getBlock"}' ${RPC_SERVER} | jq -r .result.block.header.number)
RPC_DEC_BLOCK=$(printf "%d\n" $RPC_HEX_BLOCK)

LOCAL_HEX_BLOCK=$(curl -sH "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "chain_getBlock"}' ${LOCAL_RPC} | jq -r .result.block.header.number)
LOCAL_DEC_BLOCK=$(printf "%d\n" $LOCAL_HEX_BLOCK)


echo ""
echo "-------------------------"
echo `date`
echo "rpc block:" ${RPC_DEC_BLOCK}
echo "local block:" ${LOCAL_DEC_BLOCK}


if [[ $(bc -l <<< "${RPC_DEC_BLOCK} - ${LOCAL_DEC_BLOCK}") -gt ${BLOCK_DIFF} ]]
  then
    echo "ALARM! ${NODE_NAME} LOCAL node on ${HOSTNAME} is behind RPC node"
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "${HOSTNAME} inform you:" "ALARM! ${NODE_NAME} LOCAL node on ${HOSTNAME} is behind RPC node"  2>&1 > /dev/null
fi


if [[ $(bc -l <<< "${LOCAL_DEC_BLOCK} - ${RPC_DEC_BLOCK}") -gt ${BLOCK_DIFF} ]]
  then
    echo "ALARM! ${NODE_NAME} RPC node is behind ${HOSTNAME} local node"
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "${HOSTNAME} inform you:" "ALARM! ${NODE_NAME} RPC node is behind ${HOSTNAME} local node"  2>&1 > /dev/null
fi

