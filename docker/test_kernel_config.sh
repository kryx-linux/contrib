#!/bin/bash

# Script to check Kernel Config
# Options taken from: http://docs.docker.io/en/latest/installation/kernel/
#
# USAGE: ./testconfig.sh [ /path/to/kernel/config ]

if [[ $# -lt 1 ]]; then
    if [[ -e /proc/config.gz ]]; then
        CONFIG=$(mktemp)
        zcat /proc/config.gz > $CONFIG
    else
        echo "Usage: $self [ /path/to/kernel/config ]"
        exit 1
    fi
else
    CONFIG=${1}
fi

echo "Checking Networking:"
egrep "CONFIG_BRIDGE=.$" $CONFIG
egrep "CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=.$" $CONFIG
egrep "CONFIG_NF_NAT=.$" $CONFIG
egrep "CONFIG_NF_NAT_IPV4=.$" $CONFIG
egrep "CONFIG_NF_NAT_NEEDED=.$" $CONFIG
echo

echo "Checking LVM:"
egrep CONFIG_BLK_DEV_DM $CONFIG
egrep CONFIG_DM_THIN_PROVISIONING $CONFIG
egrep CONFIG_EXT4_FS $CONFIG
echo

echo "Checking Namespaces:"
egrep CONFIG_NAMESPACES $CONFIG
egrep CONFIG_UTS_NS $CONFIG
egrep CONFIG_IPC_NS $CONFIG
egrep CONFIG_UID_NS $CONFIG
egrep CONFIG_PID_NS $CONFIG
egrep CONFIG_NET_NS $CONFIG
echo

echo "Checking Cgroups:"
egrep CONFIG_CGROUPS $CONFIG
echo

echo "Checkin gCgroup controllers (optional but highly recommended):"
egrep CONFIG_CGROUP_CPUACCT $CONFIG
egrep CONFIG_BLK_CGROUP $CONFIG
egrep CONFIG_MEMCG $CONFIG
egrep CONFIG_MEMCG_SWAP $CONFIG
echo 

echo "Running lxc-checkconfig:"
CONFIG=$CONFIG /usr/bin/lxc-checkconfig
