#!/bin/bash

# Script to check Kernel Config
# Options taken from: http://docs.docker.io/en/latest/installation/kernel/
#
# USAGE: ./testconfig.sh [ /path/to/kernel/config ]


NETWORKING_MODULES=(
    ^CONFIG_BRIDGE\=[ym]$
    ^CONFIG_NETFILTER_XT_MATCH_ADDRTYPE\=[ym]$
    ^CONFIG_NETFILTER_XT_MATCH_CONNTRACK\=[ym]$
    ^CONFIG_IP_NF_TARGET_MASQUERADE\=[ym]$
    ^CONFIG_IP_NF_FILTER\=[ym]$
    ^CONFIG_NF_NAT\=[ym]$
    ^CONFIG_NF_NAT_IPV4\=[ym]$
    ^CONFIG_NF_NAT_NEEDED\=[ym]$
)

LVM_MODULES=(
    ^CONFIG_BLK_DEV_DM\=[ym]$
    ^CONFIG_DM_THIN_PROVISIONING\=[ym]$
    ^CONFIG_EXT4_FS\=[ym]$
)

NAMESPACE_MODULES=(
    ^CONFIG_NAMESPACES\=[ym]$
    ^CONFIG_UTS_NS\=[ym]$
    ^CONFIG_IPC_NS\=[ym]$
    ^CONFIG_PID_NS\=[ym]$
    ^CONFIG_NET_NS\=[ym]$
)

CGROUPS_MODULES=(
    ^CONFIG_CGROUPS\=[ym]$
)

CGROUPS_CONTROLLERS_MODULES=(
    ^CONFIG_CGROUP_CPUACCT\=[ym]$
    ^CONFIG_BLK_CGROUP\=[ym]$
    ^CONFIG_MEMCG\=[ym]$
    ^CONFIG_MEMCG_SWAP\=[ym]$
)


function test_config() {
    local desc=${1}
    local -a modules=("${@:2}")

    echo "Checking $desc:"

    for module in ${modules[@]}; do
        echo -n " $module "
        if [[ $(egrep $module $CONFIG) ]]; then
            echo "OK"
        else
            echo "ERR"
            exit 1
        fi
    done
    echo
}


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


test_config "Networking" "${NETWORKING_MODULES[@]}"
test_config "LVM" "${LVM_MODULES[@]}"
test_config "Namespaces" "${NAMESPACE_MODULES[@]}"
test_config "CGroups" "${CGROUPS_MODULES[@]}"
test_config "CGroups Controllers" "${CGROUPS_CONTROLLERS_MODULES[@]}"

echo "You are ready to Docker rock 'n roll!"
