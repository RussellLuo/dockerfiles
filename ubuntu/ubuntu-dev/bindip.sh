#!/usr/bin/env bash

# Borrowed from http://yaxin-cn.github.io/Docker/docker-container-use-static-IP.html

if [ `id -u` -ne 0 ];then
    echo "Must use root privilege"
    exit
fi

if [ $# != 2 ]; then
    echo "Usage: $0 <Container Name> <IP>"
    exit 1
fi

container_name=$1
bind_ip=$2

container_id=`docker inspect -f '{{.Id}}' $container_name 2> /dev/null`
if [ ! $container_id ];then
    echo "Container does not exist"
    exit 2
fi
bind_ip=`echo $bind_ip | egrep '^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$'`
if [ ! $bind_ip ];then
    echo "Invalid IP address"
    exit 3
fi

container_minid=`echo $container_id | cut -c 1-10`
container_netmask=`ip addr show docker0 | grep "inet\b" | awk '{print $2}' | cut -d / -f2`
container_gw=`ip addr show docker0 | grep "inet\b" | awk '{print $2}' | cut -d / -f1`

bridge_name="veth_$container_minid"
container_ip=$bind_ip/$container_netmask
pid=`docker inspect -f '{{.State.Pid}}' $container_name 2> /dev/null`
if [ ! $pid ];then
    echo "Fail to get the id of $container_name"
    exit 4
fi

if [ ! -d /var/run/netns ];then
    mkdir -p /var/run/netns
fi

ln -sf /proc/$pid/ns/net /var/run/netns/$pid

ip link add $bridge_name type veth peer name X
brctl addif docker0 $bridge_name
ip link set $bridge_name up
ip link set X netns $pid
ip netns exec $pid ip link set dev X name eth0
ip netns exec $pid ip link set eth0 up
ip netns exec $pid ip addr add $container_ip dev eth0
ip netns exec $pid ip route add default via $container_gw
