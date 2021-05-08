#!/bin/bash

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
NODE_NAME=Sora
RPC_SERVER="http://sora.rpc.lux8.net/"
BLOCK_DIFF=10


RPC_HEX_BLOCK=$(curl -sH "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "chain_getBlock"}' ${RPC_SERVER} | jq -r .result.block.header.number)
RPC_DEC_BLOCK=$(printf "%d\n" $RPC_HEX_BLOCK)


LOCAL_SUBSTRATE_BLOCK_HEIGHT=$(curl -s http://localhost:9090/api/v1/query?query=substrate_block_height)
LOCAL_BEST=$(echo ${LOCAL_SUBSTRATE_BLOCK_HEIGHT} | jq -r '.data.result[] | select(.metric.status=="best") | .value[1]')
LOCAL_FINAL=$(echo ${LOCAL_SUBSTRATE_BLOCK_HEIGHT} | jq -r '.data.result[] | select(.metric.status=="finalized") | .value[1]')
LOCAL_TARGET=$(echo ${LOCAL_SUBSTRATE_BLOCK_HEIGHT} | jq -r '.data.result[] | select(.metric.status=="sync_target") | .value[1]')


echo ""
echo "-------------------------"
echo `date`
echo "rpc block:" ${RPC_DEC_BLOCK}
echo "local best:" ${LOCAL_BEST}
echo "local final:" ${LOCAL_FINAL}
echo "local target:" ${LOCAL_TARGET}


if [[ $(bc -l <<< "${RPC_DEC_BLOCK} - ${LOCAL_FINAL}") -gt ${BLOCK_DIFF} ]]
  then
    echo "ALARM! ${NODE_NAME} LOCAL node on ${HOSTNAME} is behind RPC node"
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "${HOSTNAME} inform you:" "ALARM! ${NODE_NAME} LOCAL node on ${HOSTNAME} is behind RPC node"  2>&1 > /dev/null
fi


if [[ $(bc -l <<< "${LOCAL_FINAL} - ${RPC_DEC_BLOCK}") -gt ${BLOCK_DIFF} ]]
  then
    echo "ALARM! ${NODE_NAME} RPC node is behind ${HOSTNAME} local node"
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "${HOSTNAME} inform you:" "ALARM! ${NODE_NAME} RPC node is behind ${HOSTNAME} local node"  2>&1 > /dev/null
fi

