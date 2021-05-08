#!/bin/bash

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
mkdir -p $HOME/logs

crontab -l | 
{
    echo "#crontab for $USER on $HOSTNAME"
    echo "* * * * * cd $SCRIPT_DIR && ./check_peers_rpc.sh >> $HOME/logs/check_peers_rpc.log ";
    echo "* * * * * cd $SCRIPT_DIR && ./check_sync_rpc.sh >> $HOME/logs/check_sync_rpc.log ";
#    echo "0 */4 * * * cd $SCRIPT_DIR && ./check_sidecar.sh >> $HOME/logs/check_sidecar.log ";
} | crontab -

echo "done"
crontab -l
