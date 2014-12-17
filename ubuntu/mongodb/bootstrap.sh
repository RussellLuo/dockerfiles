#!/bin/bash

set -e

REPLSETNAME=${REPLSETNAME:=default}
REPLSETMEMBERS=${REPLSETMEMBERS:=1}
AUTH=${AUTH:=false}
USERNAME=${USERNAME:=root}
PASSWORD=${PASSWORD:=root}

SUPERVISOR_CONF_D=/etc/supervisor/conf.d
INIT_SCRIPT=/tmp/init.js
IPADDR=$(dirname $(ip -f inet -o addr show eth0|awk '{print $4}'))

if [ "${AUTH}" != "false" ]; then
    AUTHCONF="--auth"
else
    AUTHCONF=
fi

echo "rs.initiate({_id: \"${REPLSETNAME}\", members: [" >> ${INIT_SCRIPT}

for i in $(seq "${REPLSETMEMBERS}"); do
    PORT=$(expr 27016 + $i)
    DBPATH="/var/lib/mongodb/${REPLSETNAME}-${i}"

    mkdir -p ${DBPATH}
    chown mongodb ${DBPATH}

    cat > "${SUPERVISOR_CONF_D}/mongodb-${i}.conf" <<EOF
[program:mongodb-${i}]
user = mongodb
command = /usr/bin/mongod --config /etc/mongodb.conf --replSet '${REPLSETNAME}' --port '${PORT}' --dbpath '${DBPATH}' ${AUTHCONF}
autorestart = true
EOF

    echo "{_id: ${i}, host: \"${IPADDR}:${PORT}\"}," >> ${INIT_SCRIPT}
done

echo "]});" >> ${INIT_SCRIPT}

if [ "${AUTH}" != "false" ]; then
    # add an administrator
    echo "" >> ${INIT_SCRIPT}
    echo "sleep(10000);" >> ${INIT_SCRIPT}
    echo "" >> ${INIT_SCRIPT}
    echo "use admin" >> ${INIT_SCRIPT}
    echo "db.addUser(\"${USERNAME}\", \"${PASSWORD}\");" >> ${INIT_SCRIPT}
    echo "" >> ${INIT_SCRIPT}
    echo "exit" >> ${INIT_SCRIPT}
fi

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
